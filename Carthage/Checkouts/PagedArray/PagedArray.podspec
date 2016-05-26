Pod::Spec.new do |s|
  s.name             = "PagedArray"
  s.version          = "0.3.1"
  s.summary          = "A Swift data structure for easier pagination"
  s.description      = <<-DESC
                       PagedArray is a generic Swift data structure for helping
                       you implement paging mechanisms in (but not limited to)
                       UITableViews, UICollectionViews and UIPageViewControllers.
                       DESC
  s.homepage         = "https://github.com/MrAlek/PagedArray"
  s.license          = 'MIT'
  s.author           = { "Alek Åström" => "alek@iosnomad.com" }
  s.source           = { :git => "https://github.com/MrAlek/PagedArray.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MisterAlek'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/*'
  s.frameworks = 'Foundation'

end
