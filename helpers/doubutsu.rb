def animal_photo(data)
  # content_tag(:a, href: "images/#{data.picture}.jpg", title: data.title) do
  link_to "images/#{data.picture}.jpg", title: data.title do
    image_tag "#{data.picture}_s.jpg"
  end
end

def animal_photo2
  markup do |m|
    m.div(class: 'gallery') do
      data.doubutsu.each do |kemono|
        m.a(href: "images/#{kemono[:picture]}.jpg", title: kemono[:title]) do
          m << image_tag("#{kemono[:picture]}_s.jpg")
        end
      end
    end
  end
end
