#!/bin/bash

tossh()
{


#aqui tomamos el origin para la release, siendo ORIGIN el link repositorio
repo_full_name=$(git config --get remote.origin.url)
#repo_full_name=$(echo $all_json | jq -r .github_repo )
url=$repo_full_name
echo $url
# aqui parseamos el link del repositorio, sea http o ssh (recomiendo usar ssh)
re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"
if [[ $url =~ $re ]]; then    
    protocol=${BASH_REMATCH[1]}
    separator=${BASH_REMATCH[2]}
    hostname=${BASH_REMATCH[3]}
    user=${BASH_REMATCH[4]}
    repo=${BASH_REMATCH[5]}
fi

echo "$protocol|$separator|$hostname|$separator|$user|$repo "
echo "$hostname"
if test "$hostname" = "github.com"
then
	echo "====== Before ======"
	echo ''
	echo $url
	git remote rm origin
	echo ''
	echo "====== Now ======"
	echo ''
	git remote add origin "git@github.com:$user/$repo.git"
	git config --get remote.origin.url
else
	echo "only github repos"
fi



}

inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

if [ "$inside_git_repo" ]
then
	tossh 
	echo ''
	echo '=================================='
	read -p "Press any key to continue . . ."
	exit 0
else
	echo ''
	echo "$db_file not found"
	echo ''
	echo '=================================='
	read -p "Press any key to continue . . ."
	exit 0
fi


# me guié de esto
# https://api.github.com/repos/Microsoft/Git-Credential-Manager-for-Windows/releases/latest


