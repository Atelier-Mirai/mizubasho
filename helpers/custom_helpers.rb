include HtmlBuilder
include IrohaObject

# カスタムヘルパーの例
def some_method
  # ...何らかの処理を追加...
  'awesome method'
end

# 日本語版 loremメソッド
def iroha
  IrohaObject
end

class String
  def to_amazon_url
    "https://www.amazon.co.jp/gp/product/#{self}/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=#{self}&linkCode=as2&tag=ateliermira05-22&linkId=d9a444d6a2c93e24e44eb0b3bd6d3981"
  end

  def to_amazon_image
    "//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=#{self}&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=ateliermira05-22"
  end
end

# https://www.oiax.jp/rails/tips/nokogiri_html_builder.html
def table_of_users(users)
  markup do |m|
    m.table(id: 'users', class: 'ui table') do
      m.tr do
        m.th '姓'
        m.th '名'
        m.th '性別'
      end
      users.each do |u|
        attrs = {}
        attrs[:class] = 'admin' if u[:admin]
        m.tr(attrs) do
          m.td u[:family_name]
          m.td u[:given_name]
          m.td u[:gender] == 'male' ? '男' : '女'
        end
      end
    end
  end
end

def book_intro(book, format: :simple)
  url   = book.isbn.to_s.to_amazon_url
  image = book.isbn.to_s.to_amazon_image
  title = book.title
  desc  = book.desc

  case format
  when :simple
    content_tag :div, class: 'column' do
      link_to url, class: 'ui card', target: '_blank' do
        content_tag :div, class: 'image' do
          image_tag image
        end
      end
    end
  when :description
    link_to url, class: 'ui horizontal card', target: '_blank' do
      markup do |m|
        m.div(class: 'image') do
          m << image_tag(image, style:"width: 150px; height: auto;")
        end
        m.div(class: 'content') do
          m.div(class: 'header') do
            m << title
          end
          m.div(class: 'description') do
            desc.split("\n").each_with_index do |d, i|
              m.p do
                m << d
              end
            end
          end
        end
      end
    end
  end
end
