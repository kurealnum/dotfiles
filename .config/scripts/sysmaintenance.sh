# This code is almost entirely taken from Mr. Cejas's blog: https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/
echo "Updating system"
yay -Syu

echo "Clearing pacman cache"
pacman_cache_space_used="$(du -sh /var/cache/pacman/pkg/)"
paccache -r 
echo "Space saved: $pacman_cache_space_used" 

echo "Removing orphan packages"
yay -Qdtq | yay -Rns -

echo "Clearing ~/.cache"
home_cache_used="$(du -sh ~/.cache)"
rm -rf ~/.cache/
echo "Spaced saved: $home_cache_used"

echo "Clearing system logs"
journalctl --vacuum-time=7d



