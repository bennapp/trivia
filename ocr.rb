def ocr(image_name)
  # TODO: crop screenshot
  # http://www.wizards-toolkit.org/discourse-server/viewtopic.php?t=24162
  `convert #{image_name}.png -resize 400% -type Grayscale #{image_name}-grayscale.png`
  `convert #{image_name}-grayscale.png -normalize -modulate 60 -gamma 0.85,0.85,0.85 +dither -posterize 32 #{image_name}-normalized.png`
  # https://gist.github.com/henrik/1967035
  `tesseract -l eng #{image_name}-normalized.png #{image_name}`
  `cat #{image_name}.txt`
end
