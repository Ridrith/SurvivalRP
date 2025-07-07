# SurvivalRP - World of Warcraft Roleplay Survival Addon

A comprehensive survival addon designed specifically for World of Warcraft roleplaying, adding immersive hunger, thirst, fatigue, and temperature mechanics.

## Features

### Core Survival Mechanics
- **Hunger System**: Decreases over time, restored by eating food
- **Thirst System**: Decreases over time, restored by drinking beverages  
- **Fatigue System**: Decreases over time, restored by resting (sitting)
- **Temperature System**: Affected by zones, weather, and environment

### Visual Interface
- Draggable survival status bars
- Real-time decay rate indicators
- Color-coded status (green = good, yellow = warning, red = critical)
- Progressive visual effects that intensify as needs become critical

### Immersive Features
- Automatic emotes when resting or consuming food/drinks
- Environmental factors (weather, zones) affect decay rates
- Combat increases survival needs
- Indoor/outdoor temperature differences
- Customizable chat channels for emotes

### Food & Drink Integration
- Detects actual in-game food and drink consumption
- Different items provide varying restoration amounts
- Support for conjured food/water and regular consumables
- Database of common food items with specific effects

## Installation

1. Download the addon files
2. Extract to your `World of Warcraft\_retail_\Interface\AddOns\` folder
3. Restart World of Warcraft or reload UI (`/reload`)
4. The addon will automatically start tracking your survival stats

## Usage

### Basic Operation
- The survival bars will appear in the top-right corner of your screen
- Bars show current levels and decay over time
- Visual effects will appear when stats get critically low

### Resting
- Type `/rest` to begin resting (automatically sits your character)
- Type `/rest stop` to stop resting
- Resting slowly restores fatigue

### Food & Drink
- Simply eat or drink items as normal in-game
- The addon automatically detects consumption and restores appropriate stats
- Different food/drink types provide different restoration amounts

### Configuration
- Access settings through Interface Options or `/survivalrp config`
- Adjust decay rates, visual effects, and chat preferences
- Reset stats with `/survivalrp reset`

## Slash Commands

- `/survivalrp` or `/srp` - Show current survival stats
- `/survivalrp config` - Open configuration panel
- `/survivalrp reset` - Reset all survival stats to 100%
- `/survivalrp toggle` - Hide/show the survival UI
- `/rest` - Begin resting
- `/rest stop` - Stop resting

## Customization

The addon is highly customizable:
- Adjust decay rates for different gameplay styles
- Toggle visual effects on/off
- Change chat channels for emotes
- Modify temperature sensitivity
- Enable/disable specific systems

## Environmental Effects

### Weather
- **Rain**: Increases thirst decay
- **Snow**: Increases fatigue decay  
- **Sandstorm**: Increases both hunger and thirst decay

### Zones
- **Desert zones** (Tanaris, Uldum): Increased thirst decay
- **Cold zones** (Winterspring, Icecrown): Increased fatigue decay
- **Tropical zones**: Higher base temperature

### Activities
- **Combat**: Increases all decay rates
- **Indoors**: Warmer temperature, reduced environmental effects
- **Resting**: Restores fatigue, reduces all decay rates

## Technical Notes

- Data persists across sessions and characters
- Minimal performance impact
- Compatible with most other addons
- Uses standard WoW API functions

## Future Enhancements

Planned features for future versions:
- Sleep system requiring actual rest periods
- Cooking skill bonuses
- Group meal sharing bonuses
- Seasonal temperature variations
- Disease and health systems
- Survival skill progression

## Support

For issues, suggestions, or contributions, please visit the GitHub repository or contact the author in-game.

## License

This addon is released under the MIT License. Feel free to modify and distribute as needed for your roleplay community.