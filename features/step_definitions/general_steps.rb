# User actions

When /^I( cannot)? fill in "(.*)" with "(.*)"$/ do |cannot_fill, field, value|
    if cannot_fill
        pending "Unimplemented"
    else
        fill_in(field, :with => value)
    end
end

When /^I select "(.*)" from "(.*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I press "(.*)"$/ do |button|
    click_button(button)
end

When /^I follow "(.*)"$/ do |link|
    click_link(link)
end

# Checking page content

Then /I(?: should)?( not)? see "(.*)"/ do |should_not_see, content|
    if should_not_see
        expect(page).not_to have_text(content)
    else
        expect(page).to have_text(content)
    end
end

Then /I(?: should)?( not)? see a button with "(.*)"/ do |should_not_see, content|
    if should_not_see
        expect { page.find_button(content) }.to raise_error(Capybara::ElementNotFound)
    else
        expect { page.find_button(content) }.not_to raise_error(Capybara::ElementNotFound)
    end
end

Then /the "(.*)" checkbox(?: should| is)?( not)? be checked/ do |checkbox_name, should_not_be_checked|
    checkbox_name.gsub!(" ", "_")
    expect(page.find("##{checkbox_name.downcase}_checkbox", :visible => false).checked?).to be(!should_not_be_checked)
end

Then /^there is a "(.*?)" button$/ do |button_name|
  pending "Unimplemented"
end