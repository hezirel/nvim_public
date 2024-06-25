function! MyHighlights()
" Previous order of colors : 
" Green 
" Red 
" Yellow 
" Cyan 
" Orange 
" Violet 
"highlight VertSplit guifg=LightCyan
"highlight IndentBlanklineContextChar term=italic,bold cterm=italic guibg=GoldenRod gui=nocombine,bold
"highlight NonText ctermfg=NONE guifg=gray
"highlight Visual term=reverse cterm=reverse guibg=Grey40
"highlight ColorColumn gui=nocombine
"highlight Beacon guibg=GoldenRod ctermbg=LightBlue

highlight Pmenu guifg=#C5CDD9 guibg=NONE
highlight PmenuSel gui=underline guifg=LightBlue guibg=NONE
highlight CmpItemAbbrDeprecated guifg=#7E8294 guibg=NONE
highlight CmpItemAbbrMatch guifg=#82AAFF guibg=NONE gui=bold
highlight CmpItemAbbrMatchFuzzy guifg=#82AAFF guibg=NONE gui=bold
highlight CmpItemMenu guifg=#C792EA guibg=NONE gui=italic 
highlight CmpItemKindField guifg=#B5585F guibg=none
highlight CmpItemKindProperty guifg=#B5585F guibg=none
highlight CmpItemKindEvent guifg=#B5585F guibg=none
highlight CmpItemKindText guifg=#9fbd73 guibg=none
highlight CmpItemKindEnum guifg=#9FBD73 guibg=none
highlight CmpItemKindConstant guifg=#D4BB6C  guibg=none
highlight CmpItemKindConstructor guifg=#D4BB6C  guibg=none
highlight CmpItemKindReference guifg=#D4BB6C  guibg=none
highlight CmpItemKindFunction guibg=none guifg=#A377BF
highlight CmpItemKindStruct guibg=none guifg=#A377BF
highlight CmpItemKindClass guibg=none guifg=#A377BF
highlight CmpItemKindModule guibg=none guifg=#A377BF
highlight CmpItemKindOperator guibg=none guifg=#A377BF
highlight CmpItemKindVariable guibg=none guifg=#2ECC71
highlight CmpItemKindFile guibg=none guifg=#1E8449
highlight CmpItemKindUnit guifg=#D4A959 
highlight CmpItemKindSnippet guifg=#D4A959 
highlight CmpItemKindFolder guifg=#D4A959 
highlight CmpItemKindMethod guibg=none guifg=#6C8ED4
highlight CmpItemKindValue guibg=none guifg=#6C8ED4
highlight CmpItemKindEnumMember guibg=none guifg=#6C8ED4
highlight CmpItemKindInterface guibg=none guifg=#58B5A8
highlight CmpItemKindColor guibg=none guifg=#58B5A8
highlight CmpItemKindTypeParameter guibg=none guifg=#58B5A8
highlight CmpItemKindKeyword guifg=#d55fde guibg=none

highlight FlashLabel guifg=cyan guibg=#2E3440
highlight FlashMatch guifg=purple guibg=lightgrey
highlight NotificationInfo guifg=#C5CDD9 guibg=NONE
highlight NotificationError guifg=#BF616A guibg=NONE
highlight NotificationWarning guifg=#EBCB8B guibg=NONE
endfunction

highlight SpecialKey term=standout ctermfg=darkgray guifg=darkgray

set background=dark
let my_colorschemes = ["PaperColor", "aurora", "oldworld", "bamboo", "bamboo-multiplex", "bamboo-vulgaris", "carbonfox", "catppuccin", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha", "citruszest", "cyberdream", "darkblue", "darker", "darksolar", "deepocean", "default", "delek", "desert", "dracula", "dracula-soft", "dracula_blood", "duskfox", "earlysummer", "earlysummer_lighter", "elflord", "emerald", "evening", "evergarden", "falcon", "github_dark", "github_dark_colorblind", "github_dark_default", "github_dark_dimmed", "github_dark_high_contrast", "github_dark_tritanopia", "github_dimmed", "gruvbox-baby", "habamax", "industry", "kanagawa", "kanagawa-dragon","monokai", "kanagawa-wave", "limestone", "lunaperche", "mariana", "material", "material-darker", "material-deep-ocean", "material-oceanic", "material-palenight", "middlenight_blue", "monokai", "monokai_lighter", "moonfly", "moonlight", "morning", "murphy", "neon", "nightcity", "nightcity-afterlife", "nightcity-kabuki", "nightfly", "nightfox", "nord", "nordfox", "nordic", "northern", "oceanic", "one_monokai", "onedark", "onedark_dark", "onedark_vivid", "palenight", "pastelnight", "pastelnight-highcontrast", "quiet", "retrobox", "ron", "rose-pine", "rose-pine-main", "rose-pine-moon", "slate", "sonokai", "spaceduck", "starry", "tender", "terafox", "tokyodark", "tokyonight", "tokyonight-moon", "tokyonight-night", "tokyonight-storm", "torte", "vim-monokai-tasty", "zaibatsu"]

execute 'colorscheme' my_colorschemes[rand() % (len(my_colorschemes) - 1 ) ]

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END
