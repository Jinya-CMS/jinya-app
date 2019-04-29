package de.jinya.app.login

import android.content.Context
import android.os.Bundle
import android.text.InputType
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.github.kittinunf.fuel.core.FuelManager
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpPost
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout
import de.jinya.app.MainActivity
import de.jinya.app.R
import de.jinya.app.model.LoginData
import de.jinya.app.model.TwoFactorData
import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json
import org.apache.commons.validator.routines.EmailValidator
import org.apache.commons.validator.routines.UrlValidator
import org.jetbrains.anko.*
import org.jetbrains.anko.design.textInputEditText
import org.jetbrains.anko.design.textInputLayout
import org.jetbrains.anko.design.themedAppBarLayout
import org.jetbrains.anko.sdk27.coroutines.onClick
import org.jetbrains.anko.sdk27.coroutines.textChangedListener

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

    @UnstableDefault
    fun tryLogin(jinyaUrl: String?, email: String, password: String) {
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

    @UnstableDefault
    private fun login(username: String, password: String, deviceCode: String) {
        val loginData = LoginData(username, password, deviceCode = deviceCode)

        "/api/login"
            .httpPost()
            .body(Json.stringify(LoginData.serializer(), loginData))
            .responseString { _, response, _ ->
                if (response.isSuccessful) {
                    startActivity<MainActivity>()
                } else if (response.statusCode == 403) {
                    requestSecondFactor(username, password)
                }
            }
    }

    @UnstableDefault
    private fun requestSecondFactor(username: String, password: String) {
        val twoFactorData = TwoFactorData(username, password)

        "/api/2fa"
            .httpPost()
            .body(Json.stringify(TwoFactorData.serializer(), twoFactorData))
            .responseString { _, response, _ ->
                if (response.isSuccessful) {
                    startActivity<SecondFactorActivity>("username" to username, "password" to password)
                }
            }
    }
}

class LoginView : AnkoComponent<LoginActivity> {
    private var emailInput: TextInputEditText? = null
    private var jinyaUrlInput: TextInputEditText? = null
    private var passwordInput: TextInputEditText? = null
    private var loginButton: Button? = null
    private var emailLayout: TextInputLayout? = null
    private var passwordLayout: TextInputLayout? = null
    private var jinyaUrlLayout: TextInputLayout? = null

    @UnstableDefault
    override fun createView(ui: AnkoContext<LoginActivity>) = with(ui) {
        val preferences =
            owner.getSharedPreferences(owner.getString(R.string.preference_file_key), Context.MODE_PRIVATE)
        val jinyaUrl = preferences.getString(owner.getString(R.string.api_base_url), null)

        fun jinyaUrlValid(): Boolean {
            return if (jinyaUrl != null) {
                true
            } else {
                UrlValidator.getInstance().isValid(jinyaUrlInput?.text.toString())
            }
        }

        fun emailValid(): Boolean {
            return EmailValidator.getInstance().isValid(emailInput?.text.toString())
        }

        fun passwordValid(): Boolean {
            return passwordInput?.text?.isNotEmpty() ?: false
        }

        fun inputsValid(): Boolean {
            val jinyaUrlValid = jinyaUrlValid()
            val passwordValid = passwordValid()
            val emailValid = emailValid()

            loginButton?.isEnabled = passwordValid && emailValid && jinyaUrlValid

            return passwordValid && emailValid && jinyaUrlValid
        }

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
                    jinyaUrlLayout = textInputLayout {
                        isErrorEnabled = true
                        jinyaUrlInput = textInputEditText {
                            hintResource = R.string.login_jinya_url_label
                            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_URI
                            textChangedListener {
                                afterTextChanged {
                                    inputsValid()
                                    jinyaUrlLayout?.error = if (jinyaUrlValid()) {
                                        null
                                    } else {
                                        owner.getString(R.string.login_jinya_url_error_invalid)
                                    }
                                }
                            }
                        }
                    }.lparams(width = matchParent, height = wrapContent)
                }

                emailLayout = textInputLayout {
                    isErrorEnabled = true
                    emailInput = textInputEditText {
                        hintResource = R.string.login_email_label
                        inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
                        textChangedListener {
                            afterTextChanged {
                                inputsValid()
                                emailLayout?.error = if (emailValid()) {
                                    null
                                } else {
                                    owner.getString(R.string.login_email_error_invalid)
                                }
                            }
                        }
                    }
                }.lparams(width = matchParent, height = wrapContent)

                passwordLayout = textInputLayout {
                    isErrorEnabled = true
                    passwordInput = textInputEditText {
                        hintResource = R.string.login_password_label
                        inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
                        textChangedListener {
                            afterTextChanged {
                                inputsValid()
                                passwordLayout?.error = if (passwordValid()) {
                                    null
                                } else {
                                    owner.getString(R.string.login_password_error_invalid)
                                }
                            }
                        }
                    }
                }.lparams(width = matchParent, height = wrapContent)

                loginButton = button(R.string.action_sign_in) {
                    isEnabled = false
                    onClick {
                        if (inputsValid()) {
                            owner.tryLogin(
                                jinyaUrl ?: jinyaUrlInput?.text.toString(),
                                emailInput!!.text.toString(),
                                passwordInput!!.text.toString()
                            )
                        }
                    }
                }
            }
        }
    }
}