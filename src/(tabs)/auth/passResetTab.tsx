import { StyleSheet, Text, View } from "react-native";
import { colors } from "../../constants/colors";
import AuthLayout from "../../layouts/authLayout";
import { Feather } from "@expo/vector-icons";

const PassResetTab = () => {
  return (
    <AuthLayout backButton>
      <View style={styles.formContainer}>
        <Text style={styles.title}>Recuperação de senha</Text>
        <View style={styles.warnContainer}>
          <Feather
            name="alert-triangle"
            color={colors.dark.softWhite}
            size={48}
          />
          <Text style={styles.warn}>
            No momento, esta funcionalidade ainda está sendo trabalhada.
          </Text>
        </View>
      </View>
    </AuthLayout>
  );
};

export default PassResetTab;

const styles = StyleSheet.create({
  title: {
    fontSize: 42,
    textAlign: "center",
    fontWeight: "600",
    color: colors.dark.primary,
  },
  formContainer: {
    backgroundColor: colors.dark.softBlack,
    width: "auto",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "flex-start",
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    padding: 8,
    gap: 8,
    minHeight: "75%",
  },
  warn: {
    color: colors.dark.softWhite,
    fontSize: 14,
  },
  warnContainer: {
    alignItems: "center",
    justifyContent: "center",
    marginVertical: 24,
    gap: 12,
  },
});
