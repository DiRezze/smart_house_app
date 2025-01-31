import { Text, StyleSheet } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import BackNavigateButton from "../../components/backNavigate";
import NavPath from "../../components/navPath";
import IconCard from "../../components/iconCard";
import { doSignOut } from "../../firebase/auth";
import { useNavigation } from "@react-navigation/native";

const UserTab = () => {
  const navigation = useNavigation();
  return (
    <TabScroll>
      <BackNavigateButton />
      <Text style={styles.title}>Usuário</Text>
      <NavPath text="Configurações/Usuário" />
      <IconCard
        icon="file-text"
        color={colors.pastel.pink}
        title="Seus dados"
        onClick={() => navigation.navigate("UserData")}
      />
      <IconCard
        icon="log-out"
        color="gray"
        title="Sair"
        onClick={doSignOut}
      />
    </TabScroll>
  );
};

export default UserTab;

const styles = StyleSheet.create({
  title: {
    fontSize: 48,
    marginVertical: 32,
    textAlign: "center",
    fontWeight: 700,
    color: colors.dark.softWhite,
  },
});
