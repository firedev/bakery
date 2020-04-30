# TLDR

```
bundle
rspec
```

# Usage

```rb
order = <<~ORDER
  10 VS5
  14 MB11
  13 CF
ORDER

Bakery.new.call order
```

# Inventory

| Name | Code | Packs |
|------------------|------|-----------------------------------|
| Vegemite Scroll | VS5 | 3 @ $6.99, 5 @ $8.99 |
| Blueberry Muffin | MB11 | 2 @ $9.95, 5 @ $16.95, 8 @ $24.95 |
| Croissant | CF | 3 @ $5.95, 5 @ $9.95, 9 @ $16.99 |

# Input

```
10 VS5
14 MB11
13 CF
```

# Output

Find the most expensive comobination from the smallest amount of packs.

```
10 VS5 $17.98
  2 x 5 $8.99

14 MB11 $54.80
  1 x 8 $24.95
  3 x 2 $9.95

13 CF $25.85
  2 x 5 $9.95
  1 x 3 $5.95
```
