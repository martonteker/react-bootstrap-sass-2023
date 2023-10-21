# PowerShell Script to Create SCSS Project Structure

# Function to create a directory and a partial SCSS file inside it
function Create-ScssDirectory($path, $name) {
    $dirPath = Join-Path -Path $path -ChildPath $name
    New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
    
    $scssFileName = "_$name.scss"
    $scssFilePath = Join-Path -Path $dirPath -ChildPath $scssFileName
    New-Item -ItemType File -Path $scssFilePath -Force | Out-Null
    return "./sass/$name/$scssFileName"
}

# Create 'styles' directory
$stylesDir = "styles"
New-Item -ItemType Directory -Path $stylesDir -Force | Out-Null

# Create 'sass' and 'css' directories
$sassDir = Join-Path -Path $stylesDir -ChildPath "sass"
$cssDir = Join-Path -Path $stylesDir -ChildPath "css"
New-Item -ItemType Directory -Path $sassDir -Force | Out-Null
New-Item -ItemType Directory -Path $cssDir -Force | Out-Null

# Create 'fonts' directory inside 'css'
$fontsDir = Join-Path -Path $cssDir -ChildPath "fonts"
New-Item -ItemType Directory -Path $fontsDir -Force | Out-Null

# Create CSS files
$cssFiles = @("index.css", "bootstrap.css", "icon-fonts.css")
foreach ($cssFile in $cssFiles) {
    $cssFilePath = Join-Path -Path $cssDir -ChildPath $cssFile
    New-Item -ItemType File -Path $cssFilePath -Force | Out-Null
}

# Create SCSS directories and partials, and collect import statements
$scssDirs = @("base", "components", "layout", "pages", "themes", "abstracts", "vendors")
$importStatements = @()
foreach ($scssDir in $scssDirs) {
    $importPath = Create-ScssDirectory -path $sassDir -name $scssDir
    $importStatements += "@import '$importPath';"
}

# Create main.scss and write import statements
$mainScssPath = Join-Path -Path $stylesDir -ChildPath "main.scss"
New-Item -ItemType File -Path $mainScssPath -Force | Out-Null
$importStatements -join "`n" | Set-Content -Path $mainScssPath

Write-Host "SCSS project structure created successfully!"
