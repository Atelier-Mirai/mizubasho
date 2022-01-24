def animal_photo(data)
  link_to "images/#{data.picture}.jpg", title: data.title do
    image_tag "#{data.picture}_s.jpg"
  end
end

def animals_photo
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
