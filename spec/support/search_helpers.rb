def search_for(term)
  find("input#search").set(term)
  click_button("Go!")
end
