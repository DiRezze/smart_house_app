import { StyleSheet, Text, TouchableWithoutFeedback, View } from "react-native";
import TabScroll from "../components/tabScroll";
import AppTitle from "../components/appTitle";
import IconCard from "../components/iconCard";
import { colors } from "../constants/colors";
import { useNavigation } from "@react-navigation/native";
import { ExternalLinkTo } from "../scripts/externalLink";
import { info } from "../constants/appInfo";

const InfoTab: React.FC = () => {
  const navigation = useNavigation();

  return (
    <TabScroll>
      <Text style={styles.title}>Sobre</Text>
      <View style={styles.brand}>
        <AppTitle colorVersion={true} />
        <Text style={styles.version}>
          Versão {info.versionDetails.version} - {info.versionDetails.date}
        </Text>
      </View>

      <IconCard
        icon={"code"}
        title="Informações de versão"
        color={colors.special.milk}
        onClick={() => navigation.navigate("Version")}
      />
      <IconCard
        icon={"alert-triangle"}
        title="Reportar um erro"
        color={colors.special.coffee1}
        onClick={() => navigation.navigate("Report")}
      />
      <IconCard
        icon={"file-text"}
        title="Termos legais"
        color={colors.special.coffee2}
        onClick={() => navigation.navigate("Legal")}
      />

      <IconCard
        icon={"users"}
        title="Créditos"
        color={colors.special.coffee3}
        onClick={() => ExternalLinkTo("https://github.com/DiRezze")}
      />
    </TabScroll>
  );
};

export default InfoTab;

const styles = StyleSheet.create({
  title: {
    color: colors.dark.softWhite,
    fontWeight: 700,
    fontSize: 48,
    textAlign: "center",
    margin: 8,
  },
  brand: {
    marginVertical: 56,
    gap: 4,
  },
  version: {
    color: colors.dark.softGray,
    textAlign: "center",
    fontSize: 16,
  },
  touchable: {
    width: "100%",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
  },
});
