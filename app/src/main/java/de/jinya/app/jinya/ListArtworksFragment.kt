package de.jinya.app.art.artworks.jinya

import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import de.jinya.app.model.Artwork
import iterator
import org.jetbrains.anko.linearLayout
import org.jetbrains.anko.listView
import org.jetbrains.anko.matchParent
import org.jetbrains.anko.support.v4.UI
import org.jetbrains.anko.wrapContent
import org.json.JSONObject

class ListArtworksFragment : Fragment() {
    private val artworkAdapter = ListArtworkAdapter()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        "/api/artwork".httpGet().responseString { request, response, result ->
            if (response.isSuccessful) {
                val data = JSONObject(result.get())
                val jsonArtworks = data.getJSONArray("items").iterator<JSONObject>()
                val artworks = ArrayList<Artwork>()

                for (artwork: JSONObject in jsonArtworks) {
                    artworks.add(
                        Artwork(
                            artwork.getString("name"),
                            if (!artwork.isNull("description")) artwork.getString("description") else null,
                            artwork.getString("slug"),
                            artwork.getString("picture")
                        )
                    )
                }

                artworkAdapter.setArtworks(artworks)
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return UI {
            linearLayout {
                listView {
                    adapter = artworkAdapter
                    divider = ColorDrawable(Color.TRANSPARENT)
                }.lparams(width = matchParent, height = wrapContent)
            }
        }.view
    }
}