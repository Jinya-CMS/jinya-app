package de.jinya.app.login

import JsonEncoder
import android.content.Context
import android.os.Bundle
import android.text.InputType
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.github.kittinunf.fuel.android.extension.responseJson
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpPost
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout
import de.jinya.app.MainActivity
import de.jinya.app.R
import de.jinya.app.model.LoginData
import kotlinx.serialization.UnstableDefault
import org.jetbrains.anko.*
import org.jetbrains.anko.design.textInputEditText
import org.jetbrains.anko.design.textInputLayout
import org.jetbrains.anko.design.themedAppBarLayout
import org.jetbrains.anko.sdk27.coroutines.onClick
import org.jetbrains.anko.sdk27.coroutines.textChangedListener

class SecondFactorActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SecondFactorView().setContentView(this)
    }

    override fun onBackPressed() {
    }

    @UnstableDefault
    fun tryLogin(twoFactorCode: String) {
        login(intent.extras!!["username"]!!.toString(), intent.extras!!["password"]!!.toString(), twoFactorCode)
    }

    @UnstableDefault
    private fun login(username: String, password: String, twoFactorCode: String) {
        val preferences = getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE)
        val loginData = LoginData(username, password, twoFactorCode = twoFactorCode)

        "/api/login"
            .httpPost()
            .body(JsonEncoder.stringify(LoginData.serializer(), loginData))
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
}

class SecondFactorView : AnkoComponent<SecondFactorActivity> {
    private lateinit var secondFactorCodeLayout: TextInputLayout
    private lateinit var secondFactorCodeInput: TextInputEditText
    private lateinit var loginButton: Button

    @UnstableDefault
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

                secondFactorCodeLayout = textInputLayout {
                    isErrorEnabled = true
                    secondFactorCodeInput = textInputEditText {
                        hintResource = R.string.second_factor_second_factor_code_label
                        inputType = InputType.TYPE_CLASS_NUMBER
                        textChangedListener {
                            afterTextChanged {
                                if (secondFactorCodeInput.text?.length != 6) {
                                    secondFactorCodeLayout.error =
                                        owner.getString(R.string.second_factor_second_factor_code_error_invalid)
                                    loginButton.isEnabled = false
                                } else {
                                    secondFactorCodeLayout.error = null
                                    loginButton.isEnabled = true
                                }
                            }
                        }
                    }
                }.lparams(width = matchParent, height = wrapContent)

                loginButton = button(R.string.action_sign_in) {
                    isEnabled = false
                    onClick {
                        owner.tryLogin(secondFactorCodeInput.text.toString())
                    }
                }
            }
        }
    }
}