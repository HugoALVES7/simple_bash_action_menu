# 🛠️ Simple bash menu

This easily configurable script allows you to quickly execute actions that are frequently used. Several options are available for using it: you can run it with a custom command for specific users or for everyone, or set it to launch automatically when a terminal is opened, either for a specific user or for all users.

![Preview of the menu](https://i.imgur.com/enHKDfj.png)

## 🚀 Getting Started

### Get the script on your server!

Choose the location where you want your script to be stored (it can be anywhere).  
Once placed in the correct folder, clone the Git repository.
```bash
git clone https://github.com/HugoALVES7/simple_bash_action_menu.git
```

Now, we need to make the script executable.
```bash
chmod +x /path/to/script/menu.sh
```

### Try to run it!

```bash
/path/to/script/menu.sh
```

## ⚙️ Configuration & Customization

### 🆕 Add Actions
You can add new actions to the menu.  
To do this, modify the `show_options()` function by adding an echo:
```bash
echo "  ${YELLOW}3${RESET} - Action 3"
# Add the entry that the user must type to trigger the action, along with the action's name.
echo "  ${YELLOW}4${RESET} - Git pull my website" # example
echo "      ------------"
echo "  ${YELLOW}0${RESET} - ${RED}Exit${RESET}"
```
In the `main_menu()` function, add a `case entry` for your new action:
```bash
case "$choice" in
            1) action_1 ;;
            2) action_2 ;;
            3) action_3 ;;
            4) pull_website;; # example
```
Finally, in the `ACTION FUNCTION` section, expand the function to be executed:  
```bash
pull_website() { # example
    run_as_www-data 'cd /var/www/my_website && git pull'
    if [ $? -eq 0 ]; then
        clear
        echo "${GREEN}Pull réussi!${RESET}"
    else
        echo "${RED}Erreur lors du pull.${RESET}"
    fi
}
```

### 🔨 Customize Actions
You can add your own code inside the `action_X` functions.  
Replace the placeholder `echo` with your actual code:
```bash
action_1() {
    # Replace this with your actual logic, for example:
    cd /var/www/my_website
    git pull
}
```

### 🔧 Add Shared Functions
You can define common utility functions in `COMMON FUNCTIONS`, like this example that executes commands as the `www-data` user:
```bash
run_as_www_data() {
    chown -R www-data:www-data /var/www/
    sudo -u www-data bash -c "$1"
}

```
You can then reuse it like this in your actions:
```bash
run_as_www_data 'php bin/console cache:clear'
```

## 💻 Integration Options
You have multiple ways to simplify access or automate the launch of this script:

### ✅ Add as an Alias
For the current user:
```bash
# Replace "command_name" with the name you want.
echo "alias command_name='/path/to/script/menu.sh'" >> ~/.bashrc
source ~/.bashrc
```

For all users:
```bash
# Replace "command_name" with the name you want.
echo "alias command_name='/path/to/script/menu.sh'" | sudo tee -a /etc/bash.bashrc
source /etc/bash.bashrc
# Restart a terminal for the changes to take effect.
```

Now, all you have to do is type the name you assigned to your command to open the menu.

## 🔄 Run at User Login

For the current user:
```bash
echo "bash /path/to/your/script.sh" >> ~/.bashrc
source ~/.bashrc
```

For all users:
```bash
echo "bash /path/to/your/script.sh" | sudo tee -a /etc/bash.bashrc
source /etc/bash.bashrc
# Restart a terminal for the changes to take effect.
```

## 🔐 Security Note
The script includes a security check to prevent running it as the `www-data` user:

```bash
if [ "$current_user" == "www-data" ]; then
    echo -e "${RED}This script should not be run as www-data.${RESET}"
    exit 1
fi
```
This is intentional to avoid unsafe modifications as the web server user. Instead, use the `run_as_www_data` function to execute only what’s needed.

## 📦 Features
 - 🔒 Safe execution with user validation  
 - 🌈 Color-coded interactive terminal menu  
 - 🛠️ Easily extensible with custom actions  
 - ⚡ Shortcut integration with aliases or startup configs  
 - 👤 Supports safe delegation to www-data for web tasks  

# ✨ Enjoy and customize it to fit your needs!

