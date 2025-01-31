import { StyleSheet, Text, View, TouchableOpacity } from "react-native";
import { Feather } from "@expo/vector-icons";
import { colors } from "../constants/colors";
import BlankCard from "./blankCard";

interface IconCardProps {
  icon: React.ComponentProps<typeof Feather>["name"];
  title: string;
  color: string;
  onClick?: () => void;
}

const IconCard: React.FC<IconCardProps> = ({ icon, title, color, onClick }) => {
  const handlePress = () => {
    if (onClick) {
      onClick();
    }
  };

  return (
    <BlankCard>
      <TouchableOpacity
        onPress={handlePress}
        style={styles.container}
        activeOpacity={0.7}
      >
        <View style={{ ...styles.iconCircle, backgroundColor: color }}>
          <Feather
            name={icon}
            color={colors.dark.softWhite}
            size={32}
          />
        </View>
        <Text style={styles.text}>{title}</Text>
      </TouchableOpacity>
    </BlankCard>
  );
};

export default IconCard;

const styles = StyleSheet.create({
  iconCircle: {
    borderRadius: 999,
    padding: 16,
    alignItems: "center",
    justifyContent: "center",
    width: 64,
    height: 64,
    margin: 8,
  },
  text: {
    color: colors.dark.softWhite,
    fontSize: 20,
    textAlign: "left",
    marginLeft: 8,
    fontWeight: "700",
  },
  container: {
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-start",
    width: "100%",
  },
});
