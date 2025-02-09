import { ReactNode } from "react";
import { StyleSheet, View } from "react-native";
import { colors } from "../constants/colors";

interface LandingModalProps {
  children: ReactNode;
}
const LandingModal: React.FC<LandingModalProps> = ({ children }) => {
  return <View style={styles.modal}>{children}</View>;
};

export default LandingModal;

const styles = StyleSheet.create({
  modal: {
    backgroundColor: colors.dark.softBlack,
    minHeight: 280,
  },
});
