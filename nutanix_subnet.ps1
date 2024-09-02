# Demander à l'utilisateur de saisir les informations d'authentification
$serveur = Read-Host "Entrez le nom du serveur Nutanix"
$username = Read-Host "Entrez le nom d'utilisateur"
$password = Read-Host -AsSecureString "Entrez le mot de passe"

# Authentification à la cluster Nutanix
Connect-NutanixCluster -Server $serveur -Username $username -Password $password -AcceptInvalidSSLCerts

# Demander à l'utilisateur de saisir le chemin vers le fichier CSV
$cheminFichierCSV = Read-Host "Entrez le chemin vers le fichier CSV source (ex: C:\chemin\vers\fichier.csv)"

# Importer les données depuis le fichier CSV
$donnees = Import-Csv -Path $cheminFichierCSV

# Parcourir les données pour créer les réseaux
foreach ($ligne in $donnees) {
    $vlanID = $ligne.vlanID
    $Subnet = $ligne.Subnet
    $Vs = $ligne.Vs

    # Créer le réseau avec les valeurs spécifiées
    New-NtnxNetwork -vlanid $vlanID -Name $Subnet -vswitchname $Vs
}

# Vider la variable $donnees
$donnees = $null
