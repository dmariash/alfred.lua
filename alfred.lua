http = require("socket.http")
json = (loadfile "JSON.lua")()

cat_facts = {"There are more than 500 million domestic cats in the world, with 33 different breeds.",
"Cats 'paw' or 'knead' (repeatedly treading on a spot - sometimes its owner) to mark their territory. Cats sweat through the bottom of their paws and rub off the sweat as a marking mechanism.",
"Cat urine glows in the dark when a black light shines on it. If you think your cat or kitten has had an accident in your home, use a black light to find the mishap.",
"The print on a cat's nose has a unique ridged pattern, like a human fingerprint.",
"25% of cat owners admit to blow drying their cat's hair after a bath.",
"If your cat is near you, and her tail is quivering, this is the greatest expression of love your cat can give you.",
"If your cat is thrashing its tail, she is in a bad mood - time for you to keep your distance!",
"Only domestic cats hold their tails straight up while walking. Wild cats hold their tails horizontally or tucked between their legs while walking.",
"During her productive life, one female cat could have more than 100 kittens. A single pair of cats and their kittens can produce as many as 420,000 kittens in just 7 years.",
"Sir Isaac Newton, discoverer of the principles of gravity, also invented the cat door.",
"The more you talk to your cat, the more it will speak to you.",
"Kittens begin dreaming when they are over one week old.",
"A group of kittens is called a 'kindle.' A group of grown cats is called a 'clowder.' A male cat is called a 'tom,' a female cat is called a 'molly' or 'queen', and young cats are called 'kittens.'",
"Cats spend 30% of their waking hours grooming themselves.",
"Each year Americans spend four billion dollars on cat food. That's one billion dollars more than they spend on baby food!",
"Cats can make over 100 vocal sounds, while dogs can only make 10.",
"The majority of cats do not have any eyelashes.",
"Cats have been used to deliver mail: In Belgium in 1879, 37 cats were used to deliver mail to villages. However they found that the cats were not disciplined enough to keep it up.",
"In a lifetime, the average house cat spends approximately 10,950 hours purring.",
"A cat's jaws cannot move sideways.",
"Cats rarely meow at other cats.",
"When cats are happy, they may squeeze their eyes shut.",
"Cats don't use their voice's natural frequency range to verbally communicate feelings such as affection, anger, hunger, boredom, happiness and fear - this would be inaudible to humans as this frequency is much lower than humans can hear. Some researchers believe cats may have learned we can't hear them in their natural range and have adapted so they can relate to us on our terms.",
"The reason for the lack of mouse-flavored cat food is due to the fact that the test subjects (cats, naturally!) did not like it.",
"Cats see so well in the dark because their eyes actually reflect light. Light goes in their eyes, and is reflected back out. This means that their eyes actually work almost like built-in flashlights."}


function getWeather (location)
   b, c, h = http.request("http://api.openweathermap.org/data/2.5/weather?q=" .. location .. "&units=metric")
   return json:decode(b)
end

function on_msg_receive (msg)
  if (string.match(string.lower(msg.text), 'alfred')) then
    if (string.match(string.lower(msg.text), 'what')) then
      if (string.match(string.lower(msg.text), 'time')) then
        send_msg (msg.to.print_name, os.date("The time is %X"))
        return
      end
      if (string.match(string.lower(msg.text), 'weather')) then
        weather = getWeather('London,UK')
        temp = 'The weather in ' .. weather.name .. ' is ' .. weather.main.temp .. '°C'
        conditions = 'Current conditions are: ' .. weather.weather[1].description
        send_msg (msg.to.print_name, temp .. '\n' .. conditions)
        return
      end
    end
    if (string.match(string.lower(msg.text), 'bedroom light')) then
      if (string.match(string.lower(msg.text), 'on')) then
        http.request('http://192.168.1.8:8080/setplugs?channel=1&button=1&state=on')
        send_msg (msg.to.print_name, 'Bedroom light is on.')
        return
      end
      if (string.match(string.lower(msg.text), 'off')) then
        http.request('http://192.168.1.8:8080/setplugs?channel=1&button=1&state=off')
        send_msg (msg.to.print_name, 'Bedroom light is off.')
        return
      end
    end
    if (string.match(string.lower(msg.text), 'cabinet light')) then
      if (string.match(string.lower(msg.text), 'on')) then
        http.request('http://192.168.1.8:8080/setplugs?channel=1&button=3&state=on')
        send_msg (msg.to.print_name, 'Cabinet light is on.')
        return
      end
      if (string.match(string.lower(msg.text), 'off')) then
        http.request('http://192.168.1.8:8080/setplugs?channel=1&button=3&state=off')
        send_msg (msg.to.print_name, 'Cabinet light is off.')
        return
      end
    end
    if (string.match(string.lower(msg.text), 'fact')) then
      if (string.match(string.lower(msg.text), 'cat')) then
        fact = cat_facts[math.random(#cat_facts)]
        send_msg (msg.to.print_name, 'Ok, here is a cat fact: \n\n' .. fact)
        return
      end
    end
    if (string.match(string.lower(msg.text), 'thank')) then
      send_msg (msg.to.print_name, "You're welcome")
      return
    end
    if (string.match(string.lower(msg.text), 'cheers')) then
      send_msg (msg.to.print_name, "You're welcome")
      return
    end
  end
end

function on_secret_chat_created (peer)
end
 
function on_user_update (user)
end
 
function on_chat_update (user)
end
 
function on_get_difference_end ()
end
