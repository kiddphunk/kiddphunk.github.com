foreach file (*.jpg)

convert 134x134  $file -resize 134x134 -quality 100 thumbs/$file

end
