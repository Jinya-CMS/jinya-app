package de.jinya.app.art.artworks.jinya

import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import com.squareup.picasso.Picasso
import de.jinya.app.R
import de.jinya.app.model.Artwork
import org.jetbrains.anko.*
import org.jetbrains.anko.cardview.v7.cardView

class ListArtworkAdapter : BaseAdapter() {
    private var artworks: List<Artwork> = ArrayList()

    fun appendArtworks(items: List<Artwork>) {
        setArtworks(artworks.plus(items))
    }

    private fun setArtworks(items: List<Artwork>) {
        artworks = items

        notifyDataSetChanged()
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val item = getItem(position)

        return with(parent!!.context) {
            frameLayout {
                lparams(width = matchParent, height = wrapContent)
                cardView {
                    verticalLayout {
                        var layedOut = false
                        val imgView = imageView {
                            post {
                                if (!layedOut) {
                                    val widthFactor = width.toFloat() / item.dimensions.width.toFloat()
                                    this.layoutParams.height = (item.dimensions.height * widthFactor).toInt()
                                    this.requestLayout()
                                    layedOut = true
                                }
                            }
                        }.lparams(width = matchParent)
                        Picasso
                            .get()
                            .load(item.picture)
                            .into(imgView)
                        verticalLayout {
                            padding = dip(16)
                            textView(item.name).lparams(width = matchParent, height = wrapContent)
                            if (item.description != null) {
                                textView(item.description).lparams(width = matchParent, height = wrapContent)
                            }
                        }.lparams(width = matchParent, height = wrapContent)
                        linearLayout {
                            themedButton(R.string.action_artwork_edit, R.style.PrimaryFlatButton).lparams {
                                width = dip(0)
                                weight = 0.5f
                            }
                            themedButton(R.string.action_artwork_delete, R.style.NegativeFlatButton).lparams {
                                width = dip(0)
                                weight = 0.5f
                            }
                        }.lparams(width = matchParent, height = wrapContent)
                    }.lparams(width = matchParent, height = wrapContent)
                }.lparams(width = matchParent, height = wrapContent) {
                    bottomMargin = dip(16)
                    rightMargin = dip(16)
                    leftMargin = dip(16)
                    if (position == 0) {
                        topMargin = dip(16)
                    }
                }
            }
        }
    }

    override fun getItem(position: Int): Artwork {
        return artworks[position]
    }

    override fun getItemId(position: Int): Long {
        return artworks[position].slug.hashCode().toLong()
    }

    override fun getCount(): Int {
        return artworks.count()
    }
}

