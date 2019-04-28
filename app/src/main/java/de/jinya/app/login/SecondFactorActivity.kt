package de.jinya.app.login

import android.content.Context
import android.os.Bundle
import android.text.InputType
import androidx.appcompat.app.AppCompatActivity
import com.github.kittinunf.fuel.android.extension.responseJson
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

class SecondFactorActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SecondFactorView().setContentView(this)
    }

    override fun onBackPressed() {
    }

    fun tryLogin(twoFactorCode: CharSequence?) {
        login(intent.extras!!["username"]!!.toString(), intent.extras!!["password"]!!.toString(), twoFactorCode)
    }

    private fun login(username: CharSequence?, password: CharSequence?, twoFactorCode: CharSequence?) {
        val preferences = getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE)
        val loginData = LoginData(username, password, twoFactorCode)

        "/api/login"
            .httpPost()
            .body(JSON.stringify(loginData))
            .responseJson { _, response, result ->
                if (response.isSuccessful) {
                    val data = result.get().obj()
                    val apiKey = data.getString("apiKey")
                    val deviceCode = data.getString("deviceCode")

                    preferences.edit()
                        .putString(getString(R.string.api_token), apiKey)
                        .putString(getString(R.string.api_device_code), deviceCode)
                        .apply()

                    startActivity<MainActivity>()
                }
            }
    }

    @Serializable
    data class LoginData(val username: CharSequence?, val password: CharSequence?, val twoFactorCode: CharSequence?)
}

class SecondFactorView : AnkoComponent<SecondFactorActivity> {
    private lateinit var secondFactorCodeInput: TextInputEditText

    override fun createView(ui: AnkoContext<SecondFactorActivity>) = with(ui) {
        verticalLayout {
            lparams(width = matchParent, height = matchParent)

            themedAppBarLayout(R.style.ThemeOverlay_AppCompat_Dark_ActionBar) {
                toolbar {
                    titleResource = R.string.title_activity_second_factor
                }.lparams(width = matchParent)
            }.lparams(width = matchParent, height = wrapContent)

            verticalLayout {
                padding = dip(16)

                textInputLayout {
                    secondFactorCodeInput = textInputEditText {
                        hintResource = R.string.prompt_password
                        inputType = InputType.TYPE_CLASS_NUMBER
                    }
                }.lparams(width = matchParent, height = wrapContent)

                button(R.string.action_sign_in) {
                    onClick {
                        owner.tryLogin(secondFactorCodeInput.text)
                    }
                }
            }
        }
    }
}