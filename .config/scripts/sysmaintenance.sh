# References: Fernando Cejas (https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/)
echo "----------------------------------------------------"
echo "UPDATING SYSTEM"
echo "----------------------------------------------------"

yay -Syu

echo ""
echo "----------------------------------------------------"
echo "CLEARING PACMAN CACHE"
echo "----------------------------------------------------"

pacman_cache_space_used="$(du -sh /var/cache/pacman/pkg/)"
echo "Space currently in use: $pacman_cache_space_used"
echo ""
echo "Clearing Cache, leaving newest 2 versions:"
paccache -vrk2
echo ""
echo "Clearing all uninstalled packages:"
paccache -ruk0

echo ""
echo "----------------------------------------------------"
echo "REMOVING ORPHANED PACKAGES"
echo "----------------------------------------------------"

orphaned=$(yay -Qdtq)
if [ -n "$orphaned" ]; then
    echo "$orphaned" | yay -Rns -
else
    echo "No orphaned packages to remove."
fi

echo ""
echo "----------------------------------------------------"
echo "CLEARING HOME CACHE"
echo "----------------------------------------------------"

home_cache_used="$(du -sh ~/.cache)"
rm -rf ~/.cache/
echo "Clearing ~/.cache/..."
echo "Spaced saved: $home_cache_used"

echo ""
echo "----------------------------------------------------"
echo "CLEARING SYSTEM LOGS"
echo "----------------------------------------------------"

sudo journalctl --vacuum-time=7d
echo ""
