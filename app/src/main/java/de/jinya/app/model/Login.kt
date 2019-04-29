package de.jinya.app.model

import kotlinx.serialization.Serializable

@Serializable
data class LoginData(
    val username: String,
    val password: String,
    val twoFactorCode: String? = null,
    val deviceCode: String? = null
)

@Serializable
data class TwoFactorData(
    val username: String,
    val password: String
)