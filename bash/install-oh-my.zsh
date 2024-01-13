#!zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed "s/ZSH_THEME=.*/ZSH_THEME=\"powerlevel10k/powerlevel10k\"/g" "$HOME/.zshrc"
echo "Install FiraCode NF: https://github.com/ryanoasis/nerd-fonts and set it as your terminal font"
echo "Press any key once finished..."
read -r

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed "s/plugins=.*/plugins=( git zsh-syntax-highlighting zsh-autosuggestions )/g" "$HOME/.zshrc"

echo "Install \"gem\""
echo "Press any key once finished..."
read -r

sudo gem install colorls
cat >>"$HOME/.zshrc" <<EOL
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
fi
EOL

echo "Now update your terminal with: \"source ~/.zshrc\""
