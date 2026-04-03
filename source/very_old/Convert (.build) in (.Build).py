import nextcord
from nextcord.ext import commands
import json
import os

TOKEN = ""  # Replace with your bot token
intents = nextcord.Intents.all()
bot = commands.Bot(command_prefix="/", intents=intents)

BLOCK_ID = {
    "BalloonBlock": 1916437856,
    "BalloonStarBlock": 1973706944,
    "BrickBlock": 1608273751,
    "Button": 1678033905,
    "CaneBlock": 1298643792,
    "CaneRod": 1298644378,
    "Cannon": 845567732,
    "CarSeat": 1863051164,
    "Chair": 924419491,
    "ConcreteBlock": 845565990,
    "ConcreteRod": 845564596,
    "CornerWedge": 845567909,
    "FabricBlock": 1608274294,
    "FireworkD": 7036614604,
    "Flag": 845563550,
    "GlassBlock": 1335289047,
    "Glue": 1887147909,
    "GoldBlock": 1678364253,
    "Harpoon": 2062877865,
    "HugeMotor": 1865438463,
    "IceBlock": 1608273971,
    "Lever": 1608273289,
    "LifePreserver": 958894042,
    "MarbleBlock": 845566206,
    "MarbleRod": 845564866,
    "Mast": 845566917,
    "MegaThruster": 1358894694,
    "MetalBlock": 845565844,
    "MetalRod": 845564481,
    "Motor": 9236142098,
    "MysteryBox": 2035087825,
    "ObsidianBlock": 1335288552,
    "PlasticBlock": 1609332225,
    "Pumpkin": 1105248393,
    "RustedBlock": 845565648,
    "RustedRod": 845564347,
    "Seat": 845567578,
    "Servo": 1863050474,
    "Spring": 1863049770,
    "Star": 1916677740,
    "SteelIBeam": 845566665,
    "Step": 845568429,
    "StoneBlock": 845565497,
    "StoneRod": 845564162,
    "TNT": 932196135,
    "Throne": 845567243,
    "Thruster": 1317812037,
    "TitaniumBlock": 845566458,
    "TitaniumRod": 845565080,
    "Torch": 5717267458,
    "Truss": 845568199,
    "Wedge": 845568062,
    "Helm": 845567402,
    "Window": 845563704,
    "WinterThruster": 1298650848,
    "WoodBlock": 845568340,
    "WoodDoor": 1191997076,
    "WoodRod": 845563975,
    "WoodTrapDoor": 1191997319,
    "YellowChest": 976448763
}

@bot.event
async def on_ready():
    print(f'Bot is logged in as {bot.user}')

@bot.slash_command(name="convert", description="Upload a .build file to convert it to .Build format")
async def convert(interaction: nextcord.Interaction, file: nextcord.Attachment):
    if not file.filename.endswith(".build"):
        await interaction.response.send_message("Please upload a `.build` file!", ephemeral=True)
        return

    await interaction.response.defer()
    
    input_path = f"./{file.filename}"
    output_path = input_path.replace(".build", ".Build")
    await file.save(input_path)
    
    try:
        with open(input_path, "r", encoding="utf-8", errors="ignore") as f:
            data = json.loads(f.read())
        
        converted_data = {}
        
        for entry in data:
            block_type = entry[0]
            position = ",".join(map(str, entry[1]))
            rotation = ",".join(map(str, entry[2]))
            size = ",".join(map(str, entry[4]))
            color_values = entry[6] if entry[6] else [255, 255, 255]
            color = ",".join(map(lambda x: str(x / 255), color_values))

            block_data = {
                "Position": position,
                "Rotation": rotation,
                "Size": size,
                "Color": color,
                "Anchored": entry[5],
                "CanCollide": True,
                "Transparency": 0.0,
                "ShowShadow": True
            }

            if block_type not in converted_data:
                converted_data[block_type] = []

            converted_data[block_type].append(block_data)
        
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(converted_data, f, indent=4)
        
        await interaction.followup.send("Conversion successful!", file=nextcord.File(output_path))
    except Exception as e:
        await interaction.followup.send(f"Error converting file: {e}")
    finally:
        os.remove(input_path)
        os.remove(output_path)

@bot.slash_command(name="listblocks", description="List all available block types")
async def listblocks(interaction: nextcord.Interaction):
    block_list = "\n".join([f"{name}: {id}" for name, id in BLOCK_ID.items()])
    await interaction.response.send_message(f"**Available Blocks:**\n{block_list}")

bot.run(TOKEN)
