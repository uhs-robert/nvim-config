# Neon-Dark Theme Plugin Development Guide

This document outlines the process for converting the current neon-dark theme from a VSCode theme overlay into a standalone Neovim colorscheme plugin.

## Phase 2: Implementation Analysis

### 2.1 Color System Comparison

**Current Neon-Dark Analysis:**
- Review `lua/plugins/neon-dark/colors.lua` (59 lines)
- Document custom neon accent colors: `neonGreen`, `neonBlue`, `neonRed`, `neonYellow`, etc.
- Catalog VSCode color overrides in `color_overrides` table
- Note extended palette additions

**VSCode Theme Analysis:**
- Examine `colors/` directory in VSCode theme source
- Document base color definitions and variants
- Identify color calculation/generation patterns
- Map VSCode colors to your neon enhancements

**Action Items:**
1. Create color mapping table: `vscode_color → neon_equivalent`
2. Identify unique neon colors not in VSCode theme
3. Document color relationships and usage patterns

### 2.2 Highlight Group Audit

**Current Implementation:**
- Review `lua/plugins/neon-dark/highlights.lua` (71 lines)
- Document `group_overrides` and `extended_highlights`
- Catalog which highlight groups are customized vs inherited

**VSCode Theme Coverage:**
- Examine VSCode theme's highlight definitions
- Document all provided highlight groups by category:
  - Syntax highlighting (functions, variables, keywords, etc.)
  - UI elements (statusline, tabline, popups, etc.)
  - LSP semantic tokens
  - Treesitter groups
  - Plugin-specific highlights

**Action Items:**
1. Create comprehensive highlight group inventory
2. Map current overrides to full definitions needed
3. Identify missing groups that need implementation

### 2.3 Plugin Support Review

**Current Plugin Integrations:**
- Document terminal color handling (`terminal.lua`)
- Note `disable_nvimtree_bg = true` setting
- Review any plugin-specific configurations

**VSCode Theme Plugin Support:**
- Catalog all plugin integrations in VSCode theme:
  - LSP (diagnostics, references, etc.)
  - Treesitter (syntax highlighting)
  - Popular plugins (telescope, nvim-tree, lualine, etc.)
  - Git integration (gitsigns, fugitive)
  - Other common plugins

**Action Items:**
1. Create plugin compatibility matrix
2. Document required highlight groups per plugin
3. Prioritize plugins by importance/usage

### 2.4 Modern Features Analysis

**LSP Integration:**
- Semantic token support
- Diagnostic highlighting (errors, warnings, hints, info)
- Reference highlighting
- Inlay hints styling

**Treesitter Integration:**
- Modern syntax highlighting groups
- Language-specific customizations
- Injection highlighting

**Action Items:**
1. Document all LSP highlight groups needed
2. Map Treesitter highlight groups to color scheme
3. Test with various language servers and parsers

## Phase 3: Standalone Theme Creation

### 3.1 Plugin Structure Setup

**Directory Structure:**
```
neon-dark.nvim/
├── lua/
│   └── neon-dark/
│       ├── init.lua          # Main plugin entry
│       ├── colors.lua        # Color definitions
│       ├── highlights.lua    # Highlight groups
│       ├── terminal.lua      # Terminal colors
│       └── plugins/          # Plugin-specific highlights
│           ├── lsp.lua
│           ├── treesitter.lua
│           └── [others].lua
├── colors/
│   └── neon-dark.vim        # Vim colorscheme compatibility
└── README.md
```

**Action Items:**
1. Create clean plugin directory structure
2. Set up proper Lua module system
3. Add vim colorscheme compatibility layer

### 3.2 Color System Implementation

**Base Colors:**
```lua
-- Core palette (from analysis)
local colors = {
  -- Background/foreground
  bg = "#000000",
  fg = "#D4D4D4",
  
  -- Neon accents
  neon_green = "#39FF14",
  neon_blue = "#1F51FF",
  neon_red = "#FF073A",
  neon_yellow = "#FFFF33",
  
  -- Syntax colors (enhanced from VSCode)
  -- ... (from analysis)
}
```

**Action Items:**
1. Consolidate color definitions from analysis
2. Implement color utility functions (darken, lighten, etc.)
3. Add color validation and fallbacks

### 3.3 Comprehensive Highlight Implementation

**Core Syntax Groups:**
- Implement all vim syntax groups
- Add Treesitter highlight groups
- Include LSP semantic token support

**UI Elements:**
- Complete UI highlight group coverage
- Custom neon-themed UI elements
- Consistent visual hierarchy

**Action Items:**
1. Implement highlight groups systematically by category
2. Test each category thoroughly
3. Ensure consistent neon aesthetic throughout

### 3.4 Plugin Integration

**Priority Plugins:**
1. LSP (built-in)
2. Treesitter (built-in) 
3. Telescope
4. nvim-tree/oil.nvim
5. lualine/statusline
6. gitsigns

**Implementation Strategy:**
```lua
-- Plugin-specific highlight modules
local function setup_plugin_highlights(plugin_name, colors)
  if plugin_name == "telescope" then
    return {
      TelescopeNormal = { bg = colors.bg, fg = colors.fg },
      -- ... more telescope groups
    }
  end
end
```

**Action Items:**
1. Create modular plugin highlight system
2. Implement high-priority plugins first
3. Add plugin detection and conditional loading

### 3.5 Testing and Validation

**Test Environment Setup:**
1. Create test configuration with various plugins
2. Test across different file types and languages
3. Validate in different terminal environments

**Testing Checklist:**
- [ ] Basic syntax highlighting works
- [ ] LSP diagnostics display correctly
- [ ] Treesitter highlighting functional
- [ ] All major plugins themed consistently
- [ ] Terminal colors work properly
- [ ] No missing or broken highlight groups
- [ ] Performance acceptable (no lag)

## Phase 4: Integration and Migration

### 4.1 Plugin Packaging

**Setup Configuration:**
```lua
-- In new standalone plugin
local M = {}

function M.setup(opts)
  opts = opts or {}
  
  -- Load color definitions
  local colors = require("neon-dark.colors").get_colors(opts)
  
  -- Apply highlights
  require("neon-dark.highlights").apply(colors)
  
  -- Setup terminal colors
  require("neon-dark.terminal").setup(colors)
  
  -- Set colorscheme
  vim.g.colors_name = "neon-dark"
end

return M
```

### 4.2 Theme Configuration Update

**Update `lua/plugins/theme.lua`:**
```lua
return {
  {
    "your-username/neon-dark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("neon-dark").setup({
        -- Custom options
        transparent = false,
        italic_comments = true,
        -- ... other options
      })
    end,
  },
}
```

### 4.3 Migration Checklist

- [ ] Backup current implementation
- [ ] Complete standalone plugin development
- [ ] Test standalone plugin thoroughly
- [ ] Update theme.lua configuration
- [ ] Remove VSCode theme dependency
- [ ] Verify all functionality preserved
- [ ] Document any breaking changes

## Development Notes

### Performance Considerations
- Cache color calculations
- Lazy-load plugin-specific highlights
- Minimize startup impact

### Customization Support
- Provide user configuration options
- Allow color overrides
- Support light/dark variants
- Enable/disable specific features

### Documentation Requirements
- Comprehensive README
- Installation instructions
- Customization guide
- Plugin compatibility list
- Troubleshooting guide

### Future Enhancements
- Additional color variants
- Export to other applications (tmux, etc.)
- Integration with system theme switching
- Automated testing framework

---

This guide provides a systematic approach to creating a professional, standalone neon-dark theme plugin while preserving all current functionality and adding comprehensive coverage for modern Neovim features.