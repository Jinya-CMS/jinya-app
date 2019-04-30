package de.jinya.app.http

import kotlinx.serialization.Serializable

@Serializable
data class JinyaError(
    val message: String,
    val type: String,
    val exception: String? = null,
    val file: String? = null,
    val stack: String? = null,
    val line: Int? = null
)

@Serializable
data class JinyaErrorResponse(
    val success: Boolean,
    val error: JinyaError
)

@Serializable
data class JinyaValidationResponse(
    val success: Boolean,
    val validation: Map<String, String>
)