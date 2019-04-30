package de.jinya.app.model

import kotlinx.serialization.Serializable

@Serializable
data class Artwork(
    val name: String,
    val slug: String,
    val picture: String,
    val dimensions: ArtworkDimensions,
    val description: String? = null
)

@Serializable
data class ArtworkDimensions(
    val width: Int,
    val height: Int
)