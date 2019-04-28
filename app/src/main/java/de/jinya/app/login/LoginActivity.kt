package de.jinya.app.login

import android.content.Context
import android.os.Bundle
import android.text.InputType
import androidx.appcompat.app.AppCompatActivity
import com.github.kittinunf.fuel.core.FuelManager
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpPost
import com.google.android.material.textfield.TextInputEditText
import de.jinya.app.MainActivity
import de.jinya.app.R
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JSON
import org.jetbrains.anko.*
import org.jetbrains.anko.design.textInputEditText
import org.jetbrains.anko.design.textInputLayout
import org.jetbrains.anko.design.themedAppBarLayout
import org.jetbrains.anko.sdk27.coroutines.onClick

/**
 * A login screen that offers login via email/password.
 */
class LoginActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        LoginView().setContentView(this)
    }

    override fun onBackPressed() {
    }

    fun tryLogin(jinyaUrl: CharSequence?, email: CharSequence?, password: CharSequence?) {
        val preferences = getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE)

        if (preferences.getString(getString(R.string.api_base_url), null) == null) {
            FuelManager.instance.apply {
                basePath = jinyaUrl.toString()
                baseHeaders = mapOf("Content-Type" to "application/json")
            }
        }

        val deviceCode = preferences.getString(getString(R.string.api_device_code), null)
        preferences.edit().putString(getString(R.string.api_base_url), jinyaUrl.toString()).apply()

        if (deviceCode != null) {
            login(email, password, deviceCode)
        } else {
            requestSecondFactor(email, password)
        }
    }

    private fun login(username: CharSequence?, password: CharSequence?, deviceCode: CharSequence?) {
        val loginData = LoginData(username, password, deviceCode)

        "/api/login"
            .httpPost()
            .body(JSON.stringify(loginData))
            .responseString { _, response, _ ->
                if (response.isSuccessful) {
                    startActivity<MainActivity>()
                } else if (response.statusCode == 403) {
                    requestSecondFactor(username, password)
                }
            }
    }

    private fun requestSecondFactor(username: CharSequence?, password: CharSequence?) {
        val twoFactorData = TwoFactorData(username, password)

        "/api/2fa"
            .httpPost()
            .body(JSON.stringify(twoFactorData))
            .responseString { _, response, _ ->
                if (response.isSuccessful) {
                    startActivity<SecondFactorActivity>("username" to username, "password" to password)
                }
            }
    }

    @Serializable
    data class LoginData(val username: CharSequence?, val password: CharSequence?, val deviceCode: CharSequence?)

    @Serializable
    data class TwoFactorData(val username: CharSequence?, val password: CharSequence?)
}

class LoginView : AnkoComponent<LoginActivity> {
    private var emailInput: TextInputEditText? = null
    private var jinyaUrlInput: TextInputEditText? = null
    private var passwordInput: TextInputEditText? = null

    override fun createView(ui: AnkoContext<LoginActivity>) = with(ui) {
        val preferences =
            owner.getSharedPreferences(owner.getString(R.string.preference_file_key), Context.MODE_PRIVATE)
        val jinyaUrl = preferences.getString(owner.getString(R.string.api_base_url), null)

        verticalLayout {
            lparams(width = matchParent, height = matchParent)

            themedAppBarLayout(R.style.ThemeOverlay_AppCompat_Dark_ActionBar) {
                toolbar {
                    titleResource = R.string.title_activity_login
                }.lparams(width = matchParent)
            }.lparams(width = matchParent, height = wrapContent)

            verticalLayout {
                padding = dip(16)

                if (jinyaUrl == null) {
                    textInputLayout {
                        jinyaUrlInput = textInputEditText {
                            hintResource = R.string.prompt_jinya_url
                            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_URI
                        }
                    }.lparams(width = matchParent, height = wrapContent)
                }

                textInputLayout {
                    emailInput = textInputEditText {
                        hintResource = R.string.prompt_email
                        inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                    }
                }.lparams(width = matchParent, height = wrapContent)

                textInputLayout {
                    passwordInput = textInputEditText {
                        hintResource = R.string.prompt_password
                        inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
                    }
                }.lparams(width = matchParent, height = wrapContent)

                button(R.string.action_sign_in) {
                    onClick {
                        owner.tryLogin(jinyaUrl ?: jinyaUrlInput?.text, emailInput!!.text, passwordInput!!.text)
                    }
                }
            }
        }
    }
}