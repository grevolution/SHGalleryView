Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SHGalleryView"
  s.version      = "0.0.9"
  s.summary      = "An iOS Gallery View for Images and Videos"

  s.description  = <<-DESC
                    This is a Page View Controllers based Gallery for Images and Videos which you can use to showcase your media items. Images support zoom/pinch and you can play videos in the same flow.
                   DESC

  s.homepage      = "https://github.com/grevolution/SHGalleryView"
  s.license       = {:type => 'MIT'}
  s.author        = { "Shan Ul Haq" => "g@grevolution.me" }

  s.platform      = :ios
  s.platform      = :ios, "6.0"
  s.source        = { :git => "https://github.com/grevolution/SHGalleryView.git", :tag => s.version }
  s.source_files  = "SHGalleryView/SHGalleryView/*.{h,m}"
  s.resources     = "SHGalleryView/SHGalleryView/*.{xib}"

  s.framework  = "MediaPlayer"
  s.requires_arc = true
  s.dependency "AFNetworking/UIKit", "~>2.2"

end