test = User.create(username: "test_username", email: "test@test.com", password: "test")
tonya = User.create(username: "Tonya", email: "tonya@test.com", password: "tonya")

scandal = Show.create(name: "Scandal", network: "ABC", airdate: "Thursday", link: "google.com")
ms = Show.create(name: "Madam Secretary", network: "CBS", airdate: "Sunday", link: "apple.com")
reasons = Show.create(name: "13 Reasons Why", network: "Netflix", airdate: "N/A", link: "netflix.com")

scandal.user = test
ms.user = test
reasons = tonya
