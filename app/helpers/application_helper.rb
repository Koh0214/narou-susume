module ApplicationHelper
  #titleを動的に生成
  # def title
  #   title = @matome.title if @matome
  # end
  #
  # #descriptionを動的に生成
  # def description
  #   description = @matome.description if @matome
  # end

  def default_meta_tags
    {
      site: 'なろうまとめ',
      # title: title,
      title: 'なろうのおすすめ',
      reverse: true,
      charset: 'utf-8',
      # description: description,
      description: 'みんなで作る小説家になろうオススメランキングサイト',
      keywords: '小説家になろう, なろう, なろう小説, おすすめ, オススメ, まとめ, なま, キュレーション, 共有',
      canonical: request.original_url,
      separator: ':',
      icon: [
        # { href: image_url('favicon.ico') },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ]
      # ,
      # og: {
      #   site_name: 'なろうまとめ',
      #   title: title,
      #   description: description,
      #   type: 'website',
      #   url: request.original_url,
      #   # image: image_url('ogp.png'),
      #   locale: 'ja_JP',
      # },
      # twitter: {
      #   card: 'summary',
      #   site: '@ツイッターのアカウント名',
      # }
    }
  end
end
