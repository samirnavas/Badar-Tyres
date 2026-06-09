---
name: Traction Industrial
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#e0bfbc'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#a78a88'
  outline-variant: '#59413f'
  surface-tint: '#ffb3ae'
  primary: '#ffb3ae'
  on-primary: '#68000d'
  primary-container: '#c94242'
  on-primary-container: '#fff6f5'
  inverse-primary: '#ae2f31'
  secondary: '#c8c6c6'
  on-secondary: '#303030'
  secondary-container: '#474747'
  on-secondary-container: '#b6b5b4'
  tertiary: '#c8c6c6'
  on-tertiary: '#303030'
  tertiary-container: '#727272'
  on-tertiary-container: '#faf8f7'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffdad7'
  primary-fixed-dim: '#ffb3ae'
  on-primary-fixed: '#410005'
  on-primary-fixed-variant: '#8d141c'
  secondary-fixed: '#e4e2e1'
  secondary-fixed-dim: '#c8c6c6'
  on-secondary-fixed: '#1b1c1c'
  on-secondary-fixed-variant: '#474747'
  tertiary-fixed: '#e4e2e2'
  tertiary-fixed-dim: '#c8c6c6'
  on-tertiary-fixed: '#1b1c1c'
  on-tertiary-fixed-variant: '#474747'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  display-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  title-sm:
    fontFamily: Hanken Grotesk
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-md:
    fontFamily: Hanken Grotesk
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-sm:
    fontFamily: Hanken Grotesk
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  display-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  container-padding: 20px
  gutter: 12px
  stack-sm: 4px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style

The design system is engineered for the automotive service industry, prioritizing utility, durability, and trust. It balances a rugged, "grease-monkey" aesthetic with the precision of modern engineering. The target audience includes both technicians managing job cards and customers seeking professional vehicle care.

The visual style is **Corporate / Modern** with a **Tactile** edge. It utilizes deep, heavy backgrounds to evoke the atmosphere of a high-end garage, contrasted with sharp, high-visibility red accents that signal action and critical data. The interface feels solid and reliable, mirroring the quality of mechanical work.

## Colors

The palette is anchored by "Garage Charcoal" (#121212) to provide a high-performance dark mode environment. 

- **Primary Red:** Used for high-impact actions like "LOGIN" or "CREATE," and critical service icons. It is a bold, industrial red that commands attention without causing eye strain.
- **Secondary Surfaces:** Lighter charcoals (#2D2D2D) are used for card backgrounds and input fields to create depth against the base neutral.
- **Functional Accents:** While the system is primarily dark, a "White-Smoke" (#F5F5F5) is used for text to ensure maximum readability in low-light garage environments. Success and warning colors are used sparingly for job statuses (e.g., "Completed" or "Delayed").

## Typography

This design system utilizes **Hanken Grotesk** for its sharp, technical appearance. The typeface provides the clarity of a modern sans-serif while maintaining a certain mechanical "bite" that fits the automotive theme.

- **Headlines:** Set in Bold weights with tighter letter spacing to create a sense of strength.
- **Body:** Uses Regular weight with generous line height (1.5x) to ensure technicians can read instructions or job details quickly.
- **Labels:** Uppercase styling is recommended for category labels and small metadata to maintain an organized, tabular look typical of industrial forms.

## Layout & Spacing

The layout follows a **Fluid Grid** model optimized for mobile devices. It uses a base unit of 8px to ensure all elements align to a consistent rhythmic scale.

- **Mobile Margins:** A standard 20px side margin provides a safe area for thumb interaction and prevents content from feeling cramped against screen edges.
- **Service Grid:** Icons and service cards should follow a 3-column layout on mobile, using 12px gutters.
- **Vertical Rhythm:** Use "stack-md" (16px) for most component spacing, increasing to "stack-lg" (32px) to separate major content sections (e.g., separating the customer info from the service list).

## Elevation & Depth

Visual hierarchy is established through **Tonal Layering** rather than traditional shadows. In a dark-themed industrial app, shadows are often lost; therefore, depth is defined by color luminosity.

- **Level 0 (Background):** The darkest neutral (#121212).
- **Level 1 (Cards/Inputs):** A slightly lighter charcoal (#2D2D2D). This "lifts" the interactive elements.
- **Level 2 (Popups/Active States):** An even lighter tint (#4A4A4A) or a subtle 1px border in a muted red or gray.
- **Focus States:** Active input fields or selected service cards should use a 2px primary red stroke to indicate focus, mimicking the "glow" of diagnostic equipment.

## Shapes

The shape language is **Rounded**, balancing the harshness of the dark industrial theme with user-friendly accessibility.

- **Standard Radius:** 0.5rem (8px) for buttons and input fields.
- **Card Radius:** 1rem (16px) for major containers and job card previews.
- **Pill Shapes:** Used exclusively for status tags (e.g., "Running," "Delayed") and the floating action button (FAB) for "Create Job" to differentiate them from standard structural elements.

## Components

### Buttons
- **Primary:** Solid primary red with white uppercase text. High-contrast and bold.
- **Secondary:** Outlined with a 1.5px primary red stroke and transparent background.
- **Tertiary:** Ghost style with primary red text for low-priority actions like "Add Service."

### Input Fields
- Backgrounds use Level 1 charcoal.
- Include thin-stroke icons (2px stroke weight) on the left side to provide visual cues for the data type (e.g., a person icon for "Customer Name").
- Placeholder text should be in a muted gray (#A0A0A0).

### Service Cards
- Square-ish aspect ratio in a grid.
- Features a centered red outlined icon.
- Text labels are placed below the icon in "label-sm" typography, ensuring clarity.

### Bottom Navigation
- Fixed at the bottom with a subtle blur or solid dark background.
- Active state uses the primary red for the icon and label.
- The center "Create Job" action is promoted via a larger, circular FAB-style button with a plus icon.

### Data Tables (Job Cards)
- Use subtle horizontal dividers in Level 2 charcoal.
- Column headers should be condensed and slightly darker to keep the focus on the row data (Service/Amount).