# 日本語版 loremメソッド
def iroha
  IrohaObject
end

class String
  def to_amazon_url
    "https://www.amazon.co.jp/dp/#{self}"
  end

  def to_amazon_image
    "#{self}.webp"
  end

  def count_word
    return self.split(/\s+/).size
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

def book_desc_intro
  url   = "4295008052".to_s.to_amazon_url
  image = "4295008052".to_s.to_amazon_image
  title = "Ruby on Rails 6 実践ガイド"
  desc  = <<~EOL
            本書では、1つの企業向け顧客管理システムを作る過程で、RailsによるWebアプリケーション開発の基礎知識とさまざまなノウハウを習得していきます。各章末には演習問題が設けられているので、理解度を確かめながら確実に読み進められます。
            著者が試行錯誤を繰り返した上でのベストプラクティスを提供し、読者は、実際に業務システムを構築しながらRailsのさまざまな機能、方法、作法、メソッド、テクニックを学ぶことができます。
            仮想環境における開発環境の構築/Railsアプリケーションの基盤ユーザー認証とDB処理/堅牢なシステム設計/テストフレームワーク―業務システムの構築を通じて、Railsアプリケーション開発をマスターできます。
          EOL

  link_to url do
    markup do |m|
      m.div(class: 'image') do
        m << image_tag(image, style: "width: 100%;")
      end
      m.div(class: 'content') do
        m.div(class: 'ui header') do
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

def book_intro(book, format: :simple)
  url   = book.isbn.to_s.to_amazon_url
  image = book.isbn.to_s.to_amazon_image
  title = book.title
  desc  = book.desc

  case format
  when :simple
    # content_tag :div, class: 'column' do
      link_to url, target: '_blank' do
        # content_tag :div, class: 'image' do
          image_tag image, class: 'ui small image', size: '150x212', style: 'width: 150px; height: 212px;'
        # end
      end
    # end
  when :description
    link_to url, class: 'card', style: 'width: auto;', target: '_blank' do
      markup do |m|
        m.div(class: 'content') do
          m << image_tag(image, class: 'ui left floated small image', style:"width: 150px; height: 212px;")
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
  when :large_description
    link_to url, class: 'ui card', target: '_blank', style: 'text-decoration: none;' do
      markup do |m|
        m.div(class: 'image') do
          m << image_tag(image, style:"width: 300px; height: auto;")
        end
        m.div(class: 'content') do
          m.div(class: 'header') do
            m << title
          end
          m.div(class: 'description') do
            desc.split("\n").each do |d|
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

# .ui.fluid.container
#   .billboard
#     = image_tag billboard_image
#     .catch_phrase
#       h1
#         = "#{title}"
#       p.lead
#         - a, b = "#{desc}".split(" ")
#         = a
#         br.mobile.only
#         = b

def billboard(course)
  markup do |m|
    m.div(class: 'ui fluid container') do
      m.div(class: 'billboard') do
        m << image_tag(course.billboard_image)
        m.div(class: 'catch_phrase') do
          m.h1(class: 'glow text') do
            m << course.title
          end
          m.p(class: 'lead') do
            a, b = course.desc.split(' ')
            m << a
            m.br(class: 'mobile only')
            m << b
          end
        end
      end
    end
  end
end

def useful_links
  usefuls = data.usefuls
  markup do |m|
    usefuls.each do |useful|
      m.h3(class: 'ui header') do m << useful.genre end
      m.p(class: 'desc') do m << useful.desc end
      m.ul(class: 'ui list') do
        useful.links.each do |link|
          m << link_list(link)
        end
      end
    end
  end
end

def link_list(link)
  markup do |m|
    m.li do
      m << link_to(link.url, class: 'ui small teal header', target: '_blank') do
        link.title
      end
      if desc = link.desc
        desc.split('  ') do |d|
          m.p(class: 'desc') do
            m << d
          end
        end
      end
    end
  end
end

def table_body
  markup(:tr) do |m|
    m.td << 'aiueo'
    m.td 'kakikukeko'
    m.td(:class => 'date') do
      m.text '3/1'
    end
  end
end

def table_row(description: 'aaa')
  markup(:tr) do |m|
    # unless view_context.instance_variable_get(:@staff_member)
    #   m.td do
    #     m << link_to(member.family_name + member.given_name,
    #      [ :admin, member, :staff_events ])
    #   end
    # end
    m.td description
    m.td(:class => "date today") do
      # m.text occurred_at.strftime("%Y/%m/%d %H:%M:%S")
      m.text 'aiueo!'
    end
  end
end

def table_user(users)
  markup do |m|
    m.table(id: 'users') do
      m.tr do
        m.th 'Family Name'
        m.th 'Given Name'
      end
      users.each do |u|
        attrs = {}
        # attrs[:class] = 'admin' if u.admin?
        m.tr(attrs) do
          m.td(:class => 'family_name bold') do
            m.text u[:family_name]
          end
          m.td u[:given_name]
        end
      end
    end
  end
end
