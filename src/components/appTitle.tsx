import { StyleSheet, Text, View } from "react-native";
import { colors } from "../constants/colors";
interface TitleProps {
  colorVersion: boolean;
}
const AppTitle: React.FC<TitleProps> = ({ colorVersion }) => {
  return (
    <Text style={colorVersion ? styles.colorAppName : styles.appName}>
      Projeto FETEPS
    </Text>
  );
};

export default AppTitle;

const styles = StyleSheet.create({
  appName: {
    color: colors.dark.softWhite,
    fontSize: 48,
    fontWeight: 600,
    textAlign: "center",
  },
  colorAppName: {
    color: colors.dark.primary,
    fontSize: 48,
    fontWeight: 600,
    textAlign: "center",
  },
});
