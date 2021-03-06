import React, { useEffect } from "react";
import { useAuth0 } from "@auth0/auth0-react";
import { useDispatch, useSelector } from "react-redux";
import { useRoutes } from "react-router-dom";
import styled, { createGlobalStyle } from "styled-components";
import {
  initApolloClient,
  isApolloClientAuthenticated,
} from "../graphql/apolloClient";
import Loader from "./Loader";
import Footer from "./Footer";
import { fetchSettings } from "../redux/settings/actions";
import { RootState } from "../redux/types";
import routes from "../routes";
import { SettingsManager } from "../settings/types";
import Settings from "../settings/Settings";
import Header from "./Header";

interface SettingsGlobalProps {
  settingsCss: string;
}

const StyledGlobal = createGlobalStyle<SettingsGlobalProps>`
  html {
    height: 100%;
  }

  body {
    margin: 0;
    height: 100%;
    ${(props) => props.settingsCss}
  }

  #root {
    height: 100%;
    overflow: hidden;
  }
`;

const StyledContentWrapper = styled.div`
  height: calc(100% - 50px);
  overflow-y: auto;
`;

const StyledContent = styled.div`
  margin: 0 auto;
  width: 1000px;

  @media (max-width: 768px) {
    width: 100%;
  }
`;

const App = () => {
  const { isAuthenticated, getAccessTokenSilently } = useAuth0();
  const dispatch = useDispatch();
  const isLoading: boolean = useSelector(
    (state: RootState) => state.global.isLoading
  );
  const settingsManager: SettingsManager = Settings(
    useSelector((state: RootState) => state.settings.data)
  );
  const routing = useRoutes(
    routes(isAuthenticated || isApolloClientAuthenticated())
  );

  useEffect(() => {
    initApolloClient();
    dispatch(fetchSettings());
  }, [dispatch]);

  useEffect(() => {
    const getToken = async () => {
      if (isAuthenticated) {
        const token = await getAccessTokenSilently();
        initApolloClient(token);
      }
    };
    getToken();
  }, [isAuthenticated, getAccessTokenSilently]);

  return (
    <>
      <StyledGlobal settingsCss={settingsManager.getSettingsCss()} />
      {settingsManager.isLoading ? (
        <Loader />
      ) : (
        <>
          <Header />
          <StyledContentWrapper>
            <StyledContent>
              {isLoading && (
                <Loader background={settingsManager.cssBackground.value} />
              )}
              {routing}
              <Footer />
            </StyledContent>
          </StyledContentWrapper>
        </>
      )}
    </>
  );
};

export default App;
