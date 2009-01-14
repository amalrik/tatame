Given /I am on the new dojo page/ do
  visits "/dojos/new"
end

Given /there are (\d+) dojos/ do |n|
  Dojo.transaction do
    Dojo.destroy_all
    n.to_i.times do |n|
      Dojo.create! :name => "Dojo #{n}"
    end
  end
end

When /I delete the first dojo/ do
  visits dojos_url
  clicks_link "Destroy"
end

Then /there should be (\d+) dojos left/ do |n|
  Dojo.count.should == n.to_i
  response.should have_tag("table tr", n.to_i + 1) # There is a header row too
end

Then /^"(.*)" should be the next dojo$/ do |title|
  
end

Then /^I should see an empty presence list$/ do
  
end