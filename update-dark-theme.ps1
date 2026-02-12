# Script to update all HTML pages from light theme to dark theme
# This will replace all white backgrounds with dark theme backgrounds

$files = @(
    "gallery.html",
    "about.html",
    "academics.html",
    "branches.html",
    "contact.html"
)

foreach ($file in $files) {
    $path = "c:\Users\DELL\Desktop\Pride School Folder\kids_pride\$file"
    
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        
        # Replace white backgrounds with dark card background
        $content = $content -replace 'background:\s*#fff;', 'background: var(--clr-bg-card);'
        $content = $content -replace 'background:#fff;', 'background:var(--clr-bg-card);'
        
        # Replace light cream backgrounds
        $content = $content -replace 'background:\s*var\(--clr-cream\);', 'background: var(--clr-bg-dark);'
        
        # Fix broken gradient syntax (missing linear-gradient)
        $content = $content -replace 'background:\s*var\(--clr-primary\)\s+0%,\s*transparent', 'background: linear-gradient(135deg, var(--clr-primary) 0%, transparent'
        $content = $content -replace 'background:\s*var\(--clr-primary\)\s+50%,\s*transparent', 'background: linear-gradient(90deg, var(--clr-primary) 50%, transparent'
        $content = $content -replace 'var\(--clr-primary\),\s*var\(--clr-', 'linear-gradient(90deg, var(--clr-primary), var(--clr-'
        
        # Fix specific light theme sections
        $content = $content -replace '.events-section\s*\{\s*background:\s*var\(--clr-bg-card\);', '.events-section { background: var(--clr-bg-dark);'
        $content = $content -replace '.videos-section\s*\{\s*background:\s*var\(--clr-bg-dark\);', '.videos-section { background: var(--clr-cream);'
        
        # Border colors
        $content = $content -replace 'border:\s*1px\s+solid\s+#f0ebe0;', 'border: 1px solid rgba(255, 202, 40, 0.1);'
        $content = $content -replace 'border:\s*1.5px\s+solid\s+#e2ddd4;', 'border: 1.5px solid rgba(255, 202, 40, 0.15);'
        
        # Save the updated content
        Set-Content -Path $path -Value $content -NoNewline
        
        Write-Host "Updated $file"
    }
}

Write-Host "All pages updated with dark theme!"
