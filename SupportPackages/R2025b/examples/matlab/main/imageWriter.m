function imageWriter(info, data)
  filename = info.SuggestedFilename;
  imwrite(data{:}, filename)
end