import {
  GestureResponderEvent,
  StyleSheet,
  Text,
  TouchableOpacity,
} from "react-native";
import { colors } from "../constants/colors";

interface LandingButtonProps {
  onClick?: (event: GestureResponderEvent) => void;
  text: string;
  icon?: React.ReactNode;
  primary?: boolean;
}

const LandingButton: React.FC<LandingButtonProps> = ({
  onClick,
  text,
  icon,
  primary,
}) => {
  return (
    <TouchableOpacity
      onPress={onClick}
      style={primary ? styles.primaryTouchable : styles.touchable}
    >
      {icon}
      <Text style={primary ? styles.primaryText : styles.text}>{text}</Text>
    </TouchableOpacity>
  );
};

export default LandingButton;

const styles = StyleSheet.create({
  touchable: {
    borderRadius: 200,
    padding: 6,
    margin: 12,
    width: "auto",
    backgroundColor: "transparent",
    borderColor: colors.dark.primary,
    borderWidth: 2,
  },
  primaryTouchable: {
    borderRadius: 200,
    padding: 6,
    margin: 12,
    width: "auto",
    backgroundColor: colors.dark.primary,
  },
  primaryText: {
    textAlign: "center",
    fontWeight: 600,
    fontSize: 42,
    color: colors.dark.softBlack,
  },
  text: {
    textAlign: "center",
    fontWeight: 600,
    fontSize: 42,
    color: colors.dark.primary,
  },
});
