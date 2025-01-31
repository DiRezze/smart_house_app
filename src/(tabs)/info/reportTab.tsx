import { StyleSheet, Text, View } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import BackNavigateButton from "../../components/backNavigate";
import IconCard from "../../components/iconCard";
import { ExternalLinkTo } from "../../scripts/externalLink";

const ReportTab: React.FC = () => {
  return (
    <TabScroll>
      <View style={styles.mainContainer}>
        <BackNavigateButton />
        <Text style={styles.title}>Reportar um erro</Text>
        <Text style={styles.text}>
          Escolha uma das formas a seguir para relatar o erro:
        </Text>
        <IconCard
          icon="mail"
          color={colors.pastel.blue}
          title="Relate o problema por e-mail"
          onClick={() =>
            ExternalLinkTo(
              "mailto:gabriel.rezze@etec.sp.gov.br?subject=Erro%20Reportado&body=Por%20favor%20descreva%20o%20erro%20aqui..."
            )
          }
        />
      </View>
    </TabScroll>
  );
};

export default ReportTab;

const styles = StyleSheet.create({
  title: {
    color: colors.dark.softWhite,
    fontWeight: 700,
    fontSize: 32,
    textAlign: "center",
    marginTop: 48,
    marginBottom: 32,
  },
  text: {
    color: colors.dark.softGray,
    fontSize: 16,
    margin: 8,
    textAlign: "justify",
  },
  container: {
    width: "100%",
    padding: 8,
    gap: 12,
  },
  mainContainer: {
    flex: 1,
    width: "100%",
    alignItems: "center",
  },
});
