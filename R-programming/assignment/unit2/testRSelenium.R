# Load the RSelenium library
library(RSelenium)

# Define Firefox capabilities
# capabilities <- list(
#   browserName = "firefox",
#   version = "136.0",
#   platform = "linux",
#   `moz:firefoxOptions` = list(
#     binary = "/usr/bin/firefox"
#   )
# )

# Start the remote driver with Chromium
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4445L, 
  browserName = "chrome"  # Selenium will automatically choose Chromium if it's available
)

# Open the browser
remDr$open()

# Check if the session was created successfully
if (is.na(remDr$sessionInfo$id)) {
  stop("Failed to create a session. Check Selenium server logs.")
}

# Navigate to Google
remDr$navigate("https://www.google.com")

# Get the title of the page
title <- remDr$getTitle()
print(title)

# Close the browser
remDr$close()