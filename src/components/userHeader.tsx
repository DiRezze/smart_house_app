import { Feather } from "@expo/vector-icons";
import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import { colors } from "../constants/colors";
import { getGreeting } from "../scripts/greetings";
import { useNavigation } from "@react-navigation/native";

const UserHeader = () => {
  const greeting = getGreeting() || "Olá!";

  const navigation = useNavigation();

  return (
    <View style={styles.mainContainer}>
      <View style={styles.userContainer}>
        <TouchableOpacity
          style={styles.userCircle}
          onPress={() => navigation.navigate("Perfil")}
        >
          <Feather
            name="user"
            color={colors.dark.softWhite}
            size={32}
          />
        </TouchableOpacity>
        <Text style={styles.userText}>{greeting}</Text>
      </View>
      <TouchableOpacity
        style={styles.gear}
        onPress={() => navigation.navigate("Config")}
      >
        <Feather
          name="settings"
          color={colors.dark.softWhite}
          size={32}
        />
      </TouchableOpacity>
    </View>
  );
};

export default UserHeader;

const styles = StyleSheet.create({
  mainContainer: {
    width: "100%",
    height: 64,
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  userContainer: {
    display: "flex",
    alignItems: "center",
    flexDirection: "row",
  },
  userCircle: {
    backgroundColor: colors.dark.secondary,
    padding: 4,
    borderRadius: 999,
    marginHorizontal: 16,
  },
  userText: {
    fontWeight: "bold",
    color: colors.dark.softWhite,
    fontSize: 18,
  },
  gear: {
    margin: 16,
  },
});
