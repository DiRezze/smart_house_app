import { StyleSheet, Text } from "react-native";
import { colors } from "../constants/colors";

interface NavPathInterface {
  text: string;
}

const NavPath: React.FC<NavPathInterface> = ({ text }) => {
  return <Text style={styles.text}>{text}</Text>;
};

export default NavPath;

const styles = StyleSheet.create({
  text: {
    width: "100%",
    paddingVertical: 8,
    paddingHorizontal: 24,
    fontSize: 14,
    fontWeight: 600,
    color: colors.dark.softGray,
  },
});
