# Update tags for major version(s).

MAJOR_VERSIONS=("1")
ROS_DISTROS=("humble" "jazzy")

# Tag creation function
create_tag() {
    local name=$1
    local msg_file_path="./$name-msg.txt"

    if [ ! -f "$msg_file_path" ]; then
        echo "ERROR: The tag message file $msg_file_path does not exist."
        exit 1
    fi

    git tag -fsa $name -F $msg_file_path
}


printf "Updating major version tags!\n"

for version in "${MAJOR_VERSIONS[@]}"; do
    printf "\nStarting update for v$version tags.\n"
    
    for distro in "${ROS_DISTROS[@]}"; do
        printf "\nUpdating v$version-$distro...\n"
        git checkout ros-$distro
        git push origin :refs/tags/"v$version-$distro"
        create_tag v$version-$distro

        # Old "v1" tag for backwards-compatibility. Always on Humble branch.
        if [ "$distro" = "humble" ] && [ "$version" = "1" ]; then
            printf "\nUpdating v$version...\n"
            git push origin :refs/tags/"v$version"
            create_tag v$version
        fi
    done
done

printf "\nDone, pushing new tags...\n"
git push origin --tags