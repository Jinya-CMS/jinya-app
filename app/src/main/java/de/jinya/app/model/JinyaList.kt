package de.jinya.app.model

import kotlinx.serialization.Serializable

@Serializable
data class JinyaControl(
    val next: String,
    val previous: String
)

@Serializable
data class JinyaList<E>(
    val success: Boolean,
    val offset: Int,
    val count: Int,
    val items: List<E>,
    val control: JinyaControl
)