module ApplicationHelper
  def page_title(page_title = '')
    base_title = t('site.title')

    page_title.empty? ? base_title : "#{page_title}｜#{base_title}"
  end

  def default_meta_tags
    {
      site: t('site.title'),
      title: 'お互いのことがよりわかるクイズアプリ',
      reverse: true,
      charset: 'utf-8',
      description: 'お互いに関するクイズを出し合うゲームアプリ。最低プレイ人数3人 / 推奨人数4〜6人',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@nag_runt_37',
        image: image_url('ogp.png'),
      }
    }
  end
end
