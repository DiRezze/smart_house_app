import { View, ActivityIndicator, StyleSheet } from "react-native";
import { colors } from "../constants/colors";

const Loader: React.FC = () => {
  return (
    <View style={styles.loaderContainer}>
      <ActivityIndicator
        size="large"
        color={colors.dark.primary}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  loaderContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
});

export default Loader;
