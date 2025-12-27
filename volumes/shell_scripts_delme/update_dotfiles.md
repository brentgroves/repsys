# update dotfiles

The dotfiles are updated in freshstart.sh but you could also run the following code to update just the dotfiles.

```bash
pushd .
rm -rf ~/dotfiles
cd ~
git clone https://github.com/brentgroves/dotfiles.git
popd
```
