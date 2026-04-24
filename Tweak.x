// All Codes are adapt from YTLite and uYouEnhanced + Some of my research
#import "Headers.h"

// _ASDisplayView filters
// This hook can hide A LOT of things
%hook _ASDisplayView

- (void)didMoveToWindow {
    %orig;
    if (IS_ENABLED(HideGenMusicShelf) && [self.accessibilityIdentifier isEqualToString:@"feed_nudge.view"]) self.hidden = YES;
    if (IS_ENABLED(HideLikeButton) && [self.accessibilityIdentifier isEqualToString:@"id.video.like.button"]) self.hidden = YES;
    if (IS_ENABLED(HideDisLikeButton) && [self.accessibilityIdentifier isEqualToString:@"id.video.dislike.button"]) self.hidden = YES;
    if (IS_ENABLED(HideShareButton) && [self.accessibilityIdentifier isEqualToString:@"id.video.share.button"]) self.hidden = YES;
    if (IS_ENABLED(HideDownloadButton) && [self.accessibilityIdentifier isEqualToString:@"id.ui.add_to.offline.button"]) self.hidden = YES;
    if (IS_ENABLED(HideClipButton) && [self.accessibilityIdentifier isEqualToString:@"clip_button.eml"]) self.hidden = YES;
    if (IS_ENABLED(HideRemixButton) && [self.accessibilityIdentifier isEqualToString:@"id.video.remix.button"]) self.hidden = YES;
    if (IS_ENABLED(HideSaveButton) && [self.accessibilityIdentifier isEqualToString:@"id.video.add_to.button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsLikeButton) && [self.accessibilityIdentifier isEqualToString:@"id.reel_like_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsDisLikeButton) && [self.accessibilityIdentifier isEqualToString:@"id.reel_dislike_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsCommentButton) && [self.accessibilityIdentifier isEqualToString:@"id.reel_comment_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsShareButton) && [self.accessibilityIdentifier isEqualToString:@"id.reel_share_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsRemixButton) && [self.accessibilityIdentifier isEqualToString:@"id.reel_remix_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsMetaButton) && [self.accessibilityIdentifier isEqualToString:@"id.reel_pivot_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsProducts) && [self.accessibilityIdentifier isEqualToString:@"product_sticker.main_target"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsProducts) && [self.accessibilityIdentifier isEqualToString:@"product_sticker.secondary_target"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsRecbar) && [self.accessibilityIdentifier isEqualToString:@"id.elements.components.suggested_action"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsCommit) && [self.accessibilityIdentifier isEqualToString:@"eml.shorts-disclosures"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsSubscriptButton) && [self.accessibilityIdentifier isEqualToString:@"id.ui.shorts_paused_state.subscriptions_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsLiveButton) && [self.accessibilityIdentifier isEqualToString:@"id.ui.shorts_paused_state.live_button"]) self.hidden = YES;
    if (IS_ENABLED(HideShortsToVideo) && [self.accessibilityIdentifier isEqualToString:@"id.reel_multi_format_link"]) self.hidden = YES;
}

%end

// Navigation Bar

// YouTube Premium logo
%hook YTHeaderLogoController
- (void)setTopbarLogoRenderer:(YTITopbarLogoRenderer *)renderer {
    if (!IS_ENABLED(YTPremiumLogo)) {
        %orig;
        return;
    }
    // Modify the type of the icon before setting the renderer
    YTIIcon *icon = renderer.iconImage;
    if (icon) {
        icon.iconType = 537;
    }
    %orig(renderer);
}
// For when spoofing before 18.34.5
- (void)setPremiumLogo:(BOOL)arg { IS_ENABLED(YTPremiumLogo) ? %orig(YES) : %orig; }
- (BOOL)isPremiumLogo { return IS_ENABLED(YTPremiumLogo) ? YES : %orig; }
%end

%hook YTHeaderLogoControllerImpl
- (void)setTopbarLogoRenderer:(YTITopbarLogoRenderer *)renderer {
    if (!IS_ENABLED(YTPremiumLogo)) {
        %orig;
        return;
    }
    // Modify the type of the icon before setting the renderer
    YTIIcon *icon = renderer.iconImage;
    if (icon) {
        icon.iconType = 537;
    }
    %orig(renderer);
}
// For when spoofing before 18.34.5
- (void)setPremiumLogo:(BOOL)arg { IS_ENABLED(YTPremiumLogo) ? %orig(YES) : %orig; }
- (BOOL)isPremiumLogo { return IS_ENABLED(YTPremiumLogo) ? YES : %orig; }
%end

// Hide Navigation Bar Buttons
%hook YTRightNavigationButtons
- (void)layoutSubviews {
    %orig;
    if (IS_ENABLED(HideNoti)) self.notificationButton.hidden = YES;
    if (IS_ENABLED(HideSearch)) self.searchButton.hidden = YES;
    for (UIView *subview in self.subviews) {
        if (IS_ENABLED(HideVoiceSearch) && [subview.accessibilityLabel isEqualToString:NSLocalizedString(@"search.voice.access", nil)]) subview.hidden = YES;
        if (IS_ENABLED(HideCastButtonNav) && [subview.accessibilityIdentifier isEqualToString:@"id.mdx.playbackroute.button"]) subview.hidden = YES;
    }
}
%end

%hook YTHeaderLogoController
- (id)init {
    return IS_ENABLED(HideYTLogo) ? nil : %orig;
}
%end

%hook YTHeaderLogoControllerImpl
- (id)init {
    return IS_ENABLED(HideYTLogo) ? nil : %orig;
}
%end

%hook YTNavigationBarTitleView
- (void)layoutSubviews {
    %orig;
    if (self.subviews.count > 1 && [self.subviews[1].accessibilityIdentifier isEqualToString:@"id.yoodle.logo"] && IS_ENABLED(HideYTLogo)) {
        self.subviews[1].hidden = YES;
    }
}
%end

// Hide Subbar
%hook YTMySubsFilterHeaderView
- (void)setChipFilterView:(id)arg1 { if (!(IS_ENABLED(HideSubbar))) %orig; }
%end

%hook YTHeaderContentComboView
- (void)enableSubheaderBarWithView:(id)arg1 { if (!(IS_ENABLED(HideSubbar))) %orig; }
- (void)setFeedHeaderScrollMode:(int)arg1 { IS_ENABLED(HideSubbar) ? %orig(0) : %orig; }
%end

%hook YTChipCloudCell
- (void)layoutSubviews {
    if (self.superview && IS_ENABLED(HideSubbar)) {
        [self removeFromSuperview];
    } %orig;
}
%end

%hook YTIElementRenderer
- (NSData *)elementData {
    NSString *description = [self description];
    NSArray *shortsToRemove = @[@"shorts_shelf.eml", @"shorts_video_cell.eml", @"6Shorts", @"eml.shorts-shelf"];
    for (NSString *shorts in shortsToRemove) {
        if (IS_ENABLED(HideShortsShelf) && [description containsString:shorts] && ![description containsString:@"history*"]) {
            return nil;
        }
    }
    return %orig;
}
%end

%hook YTSearchViewController
- (void)viewDidLoad {
    %orig;
    if (IS_ENABLED(HideVoiceSearch)) {
        [self setValue:@(NO) forKey:@"_isVoiceSearchAllowed"];
    }
}
- (void)setSuggestions:(id)arg1 { if (!IS_ENABLED(HideSearchHis)) %orig; }
%end

%hook YTPersonalizedSuggestionsCacheProvider
- (id)activeCache { return IS_ENABLED(HideSearchHis) ? nil : %orig; }
%end

%hook YTMainAppControlsOverlayView
// Hide autoplay Switch
- (void)setAutoplaySwitchButtonRenderer:(id)arg1 { if (!IS_ENABLED(HideAutoPlayToggle)) %orig; }
// Hide captions Button
- (void)setClosedCaptionsOrSubtitlesButtonAvailable:(BOOL)arg1 { if (!IS_ENABLED(HideCaptionsButton)) %orig; }
// Hide cast button
- (id)playbackRouteButton { return IS_ENABLED(HideCastButtonPlayer) ? nil : %orig; }
- (void)setPreviousButtonHidden:(BOOL)arg { IS_ENABLED(HidePrevButton) ? %orig(YES) : %orig; }
- (void)setNextButtonHidden:(BOOL)arg { IS_ENABLED(HideNextButton) ? %orig(YES) : %orig; }
// Hide video title in full screen
- (BOOL)titleViewHidden { return IS_ENABLED(HideFullvidTitle) ? YES : %orig; }
%end

%hook YTSettings
- (BOOL)isAutoplayEnabled { return IS_ENABLED(HideAutoPlayToggle) ? NO : %orig; }
%end

%hook YTSettingsImpl
- (BOOL)isAutoplayEnabled { return IS_ENABLED(HideAutoPlayToggle) ? NO : %orig; }
%end

/* idk what is this thing does
%hook YTColdConfig
- (BOOL)isLandscapeEngagementPanelEnabled {
    return NO;
}
%end
*/

// Remove Dark Background in Overlay
%hook YTMainAppVideoPlayerOverlayView
- (void)setBackgroundVisible:(BOOL)arg1 isGradientBackground:(BOOL)arg2 { IS_ENABLED(RemoveDarkOverlay) ? %orig(NO, arg2) : %orig; }
// Hide Watermarks
- (BOOL)isWatermarkEnabled { return IS_ENABLED(HideWaterMark) ? NO : %orig; }
- (void)setWatermarkEnabled:(BOOL)arg { IS_ENABLED(HideWaterMark) ? %orig(NO) : %orig; }
- (id)playbackRouteButton { return IS_ENABLED(HideCastButtonPlayer) ? nil : %orig; }
%end

// No Endscreen Cards
%hook YTCreatorEndscreenView
- (void)setHidden:(BOOL)arg1 { IS_ENABLED(HideEndScreenCards) ? %orig(YES) : %orig; }
- (void)setHoverCardHidden:(BOOL)arg { IS_ENABLED(HideEndScreenCards) ? %orig(YES) : %orig; }
- (void)setHoverCardRenderer:(id)arg { if (!IS_ENABLED(HideEndScreenCards)) %orig; }
%end

%hook YTMainAppVideoPlayerOverlayViewController
// Disable Double Tap To Seek
- (BOOL)allowDoubleTapToSeekGestureRecognizer { return IS_ENABLED(DisablesDoubleTap) ? NO : %orig; }
// Disable long hold
- (BOOL)allowLongPressGestureRecognizerInView:(id)arg { return IS_ENABLED(DisablesLongHold) ? NO : %orig; }
%end

// Remove Watermarks
%hook YTAnnotationsViewController
- (void)loadFeaturedChannelWatermark { if (!IS_ENABLED(HideWaterMark)) %orig; }
%end

// Exit Fullscreen on Finish
%hook YTWatchFlowController
- (BOOL)shouldExitFullScreenOnFinish { return IS_ENABLED(AutoExitFullScreen) ? YES : %orig; }
%end

// Disable toggle time remaining - @bhackel
%hook YTInlinePlayerBarContainerView
- (void)setShouldDisplayTimeRemaining:(BOOL)arg1 { 
    if (IS_ENABLED(DisablesShowRemaining)) return;
    IS_ENABLED(AlwaysShowRemaining) ? %orig(YES) : %orig(NO);
}
%end

// Always use remaining time in the video player - @bhackel
%hook YTPlayerBarController
// When a new video is played, enable time remaining flag
- (void)setActiveSingleVideo:(id)arg1 {
    %orig;
    if (IS_ENABLED(AlwaysShowRemaining) && !IS_ENABLED(DisablesShowRemaining)) {
        // Get the player bar view
        YTInlinePlayerBarContainerView *playerBar = self.playerBar;
        if (playerBar) {
            // Enable the time remaining flag
            playerBar.shouldDisplayTimeRemaining = YES;
        }
    }
}
%end

// Disable Fullscreen Actions
%hook YTFullscreenActionsView
- (BOOL)enabled { return IS_ENABLED(HideFullAction) ? NO : %orig; }
- (void)setEnabled:(BOOL)arg1 { IS_ENABLED(HideFullAction) ? %orig(NO) : %orig; }
%end

// Disable Autoplay 
%hook YTPlaybackConfig
- (void)setStartPlayback:(BOOL)arg1 { IS_ENABLED(StopAutoplayVideo) ? %orig(NO) : %orig; }
%end

// Skip Content Warning (https://github.com/qnblackcat/uYouPlus/blob/main/uYouPlus.xm#L452-L454)
%hook YTPlayabilityResolutionUserActionUIController
- (void)showConfirmAlert { IS_ENABLED(HideContentWarning) ? [self confirmAlertDidPressConfirm] : %orig; }
%end

%hook YTPlayabilityResolutionUserActionUIControllerImpl
- (void)showConfirmAlert { IS_ENABLED(HideContentWarning) ? [self confirmAlertDidPressConfirm] : %orig; }
%end

// Dont Show Related Videos on Finish
%hook YTFullscreenEngagementOverlayController
- (void)setRelatedVideosVisible:(BOOL)arg1 { IS_ENABLED(HideRelateVideo) ? %orig(NO) : %orig; }
%end

%hook YTFullscreenEngagementOverlayView
- (void)setRelatedVideosView:(id)arg { if (!IS_ENABLED(HideRelateVideo)) %orig; }
%end

// Shorts

// Enables shorts quality - works best with YTClassicVideoQuality
%hook YTHotConfig
- (BOOL)enableOmitAdvancedMenuInShortsVideoQualityPicker { return IS_ENABLED(EnablesShortsQuality) ? YES : %orig; }
- (BOOL)enableShortsVideoQualityPicker { return IS_ENABLED(EnablesShortsQuality) ? YES : %orig; }
- (BOOL)iosEnableImmersiveLivePlayerVideoQuality { return IS_ENABLED(EnablesShortsQuality) ? YES : %orig; }
- (BOOL)iosEnableShortsPlayerVideoQuality { return IS_ENABLED(EnablesShortsQuality) ? YES : %orig; }
- (BOOL)iosEnableShortsPlayerVideoQualityRestartVideo { return IS_ENABLED(EnablesShortsQuality) ? YES : %orig; }
- (BOOL)iosEnableSimplerTitleInShortsVideoQualityPicker { return IS_ENABLED(EnablesShortsQuality) ? YES : %orig; }
%end

// Always show Shorts seekbar
%hook YTShortsPlayerViewController
- (BOOL)shouldAlwaysEnablePlayerBar { return IS_ENABLED(ShowShortsSeekbar) ? YES : %orig; }
- (BOOL)shouldEnablePlayerBarOnlyOnPause { return IS_ENABLED(ShowShortsSeekbar) ? NO : %orig; }
%end

%hook YTReelPlayerViewController
- (BOOL)shouldAlwaysEnablePlayerBar { return IS_ENABLED(ShowShortsSeekbar) ? YES : %orig; }
- (BOOL)shouldEnablePlayerBarOnlyOnPause { return IS_ENABLED(ShowShortsSeekbar) ? NO : %orig; }
%end

%hook YTReelPlayerViewControllerSub
- (BOOL)shouldAlwaysEnablePlayerBar { return IS_ENABLED(ShowShortsSeekbar) ? YES : %orig; }
- (BOOL)shouldEnablePlayerBarOnlyOnPause { return IS_ENABLED(ShowShortsSeekbar) ? NO : %orig; }
%end

%hook YTColdConfig
- (BOOL)iosEnableVideoPlayerScrubber { return IS_ENABLED(ShowShortsSeekbar) ? YES : %orig; }
- (BOOL)mobileShortsTablnlinedExpandWatchOnDismiss { return IS_ENABLED(ShowShortsSeekbar) ? YES : %orig; }
%end

%hook YTHotConfig
- (BOOL)enablePlayerBarForVerticalVideoWhenControlsHiddenInFullscreen { return IS_ENABLED(ShowShortsSeekbar) ? YES : %orig; }
%end

%hook YTHeaderView
- (BOOL)stickyNavHeaderEnabled { return IS_ENABLED(YTPremiumLogo) ? YES : NO; } // idk what is this does, the nav is already sticky... Or this thing only happens in iPhone?
- (void)setStickyNavHeaderEnabled:(BOOL)arg { IS_ENABLED(YTPremiumLogo) ? %orig(YES) : %orig(NO); }
%end

// Miscellaneous

// Try to disable Shorts PiP
%hook YTColdConfig
- (BOOL)shortsPlayerGlobalConfigEnableReelsPictureInPicture { return IS_ENABLED(DisablesShortsPiP) ? NO : %orig; }
- (BOOL)shortsPlayerGlobalConfigEnableReelsPictureInPictureIos { return IS_ENABLED(DisablesShortsPiP) ? NO : %orig; }
%end

%hook YTHotConfig
- (BOOL)shortsPlayerGlobalConfigEnableReelsPictureInPictureAllowedFromPlayer { return IS_ENABLED(DisablesShortsPiP) ? NO : %orig; }
%end

%hook YTReelModel
- (BOOL)isPiPSupported { return IS_ENABLED(DisablesShortsPiP) ? NO : %orig; }
%end

%hook YTReelPlayerViewController
- (BOOL)isPictureInPictureAllowed { return IS_ENABLED(DisablesShortsPiP) ? NO : %orig; }
%end

%hook YTReelWatchRootViewController
- (void)switchToPictureInPicture { if (!IS_ENABLED(DisablesShortsPiP)) %orig; }
%end

// Block upgrade dialogs
%hook YTGlobalConfig
- (BOOL)shouldBlockUpgradeDialog { return IS_ENABLED(BlockUpgradeDialogs) ? YES : %orig; }
- (BOOL)shouldShowUpgradeDialog { return IS_ENABLED(BlockUpgradeDialogs) ? NO : %orig; }
- (BOOL)shouldShowUpgrade { return IS_ENABLED(BlockUpgradeDialogs) ? NO : %orig; }
- (BOOL)shouldForceUpgrade { return IS_ENABLED(BlockUpgradeDialogs) ? NO : %orig; }
%end

// Prevent YouTube from asking "Are you there?"
%hook YTColdConfig
- (BOOL)enableYouthereCommandsOnIos { return IS_ENABLED(BlockUpgradeDialogs) ? NO : %orig; }
%end

%hook YTYouThereController
- (BOOL)shouldShowYouTherePrompt { return IS_ENABLED(HideAreYouThereDialog) ? NO : %orig; }
- (void)showYouTherePrompt { if (!IS_ENABLED(HideAreYouThereDialog)) %orig; }
%end

%hook YTYouThereControllerImpl
- (BOOL)shouldShowYouTherePrompt { return IS_ENABLED(HideAreYouThereDialog) ? NO : %orig; }
- (void)showYouTherePrompt { if (!IS_ENABLED(HideAreYouThereDialog)) %orig; }
%end

// Fixes slow miniplayer
%hook YTColdConfig
- (BOOL)enableIosFloatingMiniplayerDoubleTapToResize { return IS_ENABLED(FixesSlowMiniPlayer) ? NO : %orig; }
%end

// Use old miniplayer
%hook YTColdConfig
- (BOOL)enableIosFloatingMiniplayer { return IS_ENABLED(DisablesNewMiniPlayer) ? NO : %orig; }
%end

%hook YTColdConfigWatchPlayerClientGlobalConfigImpl
- (BOOL)enableIosFloatingMiniplayer { return IS_ENABLED(DisablesNewMiniPlayer) ? NO : %orig; }
%end

// Disables Snackbar
%hook GOOHUDManagerInternal
- (id)sharedInstance { return IS_ENABLED(DisablesSnackBar) ? nil : %orig; }
- (void)showMessageMainThread:(id)arg { if (!IS_ENABLED(DisablesSnackBar)) %orig; }
- (void)activateOverlay:(id)arg { if (!IS_ENABLED(DisablesSnackBar)) %orig; }
- (void)displayHUDViewForMessage:(id)arg { if (!IS_ENABLED(DisablesSnackBar)) %orig; }
%end

// Hide startup animations
%hook YTColdConfig
- (BOOL)mainAppCoreClientIosEnableStartupAnimation { return IS_ENABLED(HideStartupAni) ? NO : %orig; }
%end

// Remove "Play next in queue" from the menu @PoomSmart (https://github.com/qnblackcat/uYouPlus/issues/1138#issuecomment-1606415080)
%hook YTMenuItemVisibilityHandler
- (BOOL)shouldShowServiceItemRenderer:(YTIMenuConditionalServiceItemRenderer *)renderer {
    if (renderer.icon.iconType == 251 && IS_ENABLED(HidePlayInNextQueue)) {
        return NO;
    } return %orig;
}
%end

%hook YTMenuItemVisibilityHandlerImpl
- (BOOL)shouldShowServiceItemRenderer:(YTIMenuConditionalServiceItemRenderer *)renderer {
    if (renderer.icon.iconType == 251 && IS_ENABLED(HidePlayInNextQueue)) {
        return NO;
    } return %orig;
}
%end

/*
%hook YTInlinePlayerBarContainerView
- (void)setPlayerBarAlpha:(CGFloat)alpha { %orig(1.0); } // Force seek bar i guess
%end
*/

/*
// Portrait Fullscreen
%hook YTWatchViewController
- (unsigned long long)allowedFullScreenOrientations { return PortraitFullscreen() ? UIInterfaceOrientationMaskAllButUpsideDown; } // wth is this?
%end
*/

// Disable Snap To Chapter (https://github.com/qnblackcat/uYouPlus/blob/main/uYouPlus.xm#L457-464) - GOT REMOVED
// %hook YTSegmentableInlinePlayerBarView
// - (void)didMoveToWindow { %orig; if (ytlBool(@"dontSnapToChapter")) self.enableSnapToChapter = NO; }
// %end

/*
%hook YTModularPlayerBarController
- (void)setEnableSnapToChapter:(BOOL)arg { %orig(NO); } // idk this works or not
%end
*/

%hook YTPlayerViewController
- (void)loadWithPlayerTransition:(id)arg1 playbackConfig:(id)arg2 {
    %orig;
    if (IS_ENABLED(AutoFullScreen)) [self performSelector:@selector(YouModAutoFullscreen) withObject:nil afterDelay:0.75];
    // if (ytlBool(@"shortsToRegular")) [self performSelector:@selector(shortsToRegular) withObject:nil afterDelay:0.75];
    // if (ytlBool(@"disableAutoCaptions")) [self performSelector:@selector(turnOffCaptions) withObject:nil afterDelay:1.0];
}

- (void)prepareToLoadWithPlayerTransition:(id)arg1 expectedLayout:(id)arg2 {
    %orig;
    if (IS_ENABLED(AutoFullScreen)) [self performSelector:@selector(YouModAutoFullscreen) withObject:nil afterDelay:0.75];
    // if (ytlBool(@"shortsToRegular")) [self performSelector:@selector(shortsToRegular) withObject:nil afterDelay:0.75];
    // if (ytlBool(@"disableAutoCaptions")) [self performSelector:@selector(turnOffCaptions) withObject:nil afterDelay:1.0];
}

%new
- (void)YouModAutoFullscreen {
    YTWatchController *watchController = [self valueForKey:@"_UIDelegate"];
    [watchController showFullScreen];
}

%end

/*
%new
- (void)shortsToRegular {
    if (self.contentVideoID != nil && [self.parentViewController isKindOfClass:NSClassFromString(@"YTShortsPlayerViewController")]) {
        NSString *vidLink = [NSString stringWithFormat:@"vnd.youtube://%@", self.contentVideoID]; // idk about this
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:vidLink]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vidLink] options:@{} completionHandler:nil];
        }
    }
}

%new
- (void)turnOffCaptions {
    if ([self.view.superview isKindOfClass:NSClassFromString(@"YTWatchView")]) {
        [self setActiveCaptionTrack:nil]; // will try this - got removed
    }
}
%end

// Fix Playlist Mini-bar Height For Small Screens
%hook YTPlaylistMiniBarView
- (void)setFrame:(CGRect)frame {
    if (frame.size.height < 54.0) frame.size.height = 54.0; // what
    %orig(frame);
}
%end
*/

/* untested
// Remove Download button from the menu
%hook YTDefaultSheetController
- (void)addAction:(YTActionSheetAction *)action {
    NSString *identifier = [action valueForKey:@"_accessibilityIdentifier"];

    NSDictionary *actionsToRemove = @{
        @"7": @(ytlBool(@"removeDownloadMenu")),
        @"1": @(ytlBool(@"removeWatchLaterMenu")),
        @"3": @(ytlBool(@"removeSaveToPlaylistMenu")),
        @"5": @(ytlBool(@"removeShareMenu")),
        @"12": @(ytlBool(@"removeNotInterestedMenu")),
        @"31": @(ytlBool(@"removeDontRecommendMenu")),
        @"58": @(ytlBool(@"removeReportMenu"))
    };

    if (![actionsToRemove[identifier] boolValue]) {
        %orig;
    }
}
%end
*/

%hook YTPivotBarView
- (void)setRenderer:(YTIPivotBarRenderer *)renderer {
    NSMutableArray <YTIPivotBarSupportedRenderers *> *items = [renderer itemsArray];
    NSMutableIndexSet *indicesToRemove = [NSMutableIndexSet indexSet];
    // Loop through every item in the bar
    for (NSUInteger i = 0; i < items.count; i++) {
        YTIPivotBarSupportedRenderers *item = items[i];
        NSString *pID = [[item pivotBarItemRenderer] pivotIdentifier];
        NSString *pID2 = [[item pivotBarIconOnlyItemRenderer] pivotIdentifier];
        if ([pID isEqualToString:@"FEwhat_to_watch"] && IS_ENABLED(HideHomeTab)) {
             [indicesToRemove addIndex:i];
        }
        if ([pID isEqualToString:@"FEshorts"] && IS_ENABLED(HideShortsTab)) {
            [indicesToRemove addIndex:i];
        }
        if ([pID2 isEqualToString:@"FEuploads"] && IS_ENABLED(HideCreateButton)) {
            [indicesToRemove addIndex:i];
        }
        if ([pID isEqualToString:@"FEsubscriptions"] && IS_ENABLED(HideSubscriptTab)) {
            [indicesToRemove addIndex:i];
        }
    }
    // Remove them all at once so the layout doesn't break
    [items removeObjectsAtIndexes:indicesToRemove];
    %orig(renderer);
}
%end

// Hide Tab Bar Indicators
%hook YTPivotBarIndicatorView
- (void)setFillColor:(id)arg1 { IS_ENABLED(HideTabIndi) ? %orig([UIColor clearColor]) : %orig; }
- (void)setBorderColor:(id)arg1  { IS_ENABLED(HideTabIndi) ? %orig([UIColor clearColor]) : %orig; }
%end

// Hide Tab Labels
%hook YTPivotBarItemView
- (void)setRenderer:(YTIPivotBarRenderer *)renderer {
    %orig;
    if (IS_ENABLED(HideTabLabels)) {
        [self.navigationButton setTitle:@"" forState:UIControlStateNormal];
        [self.navigationButton setSizeWithPaddingAndInsets:NO];
    }
}
%end

/* Needs to make the settings for this first 
// Startup Tab
BOOL isTabSelected = NO;
%hook YTPivotBarViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    if (!isTabSelected) {
        NSArray *pivotIdentifiers = @[@"FEwhat_to_watch", @"FEshorts", @"FEsubscriptions", @"FElibrary"];
        [self selectItemWithPivotIdentifier:pivotIdentifiers[ytlInt(@"pivotIndex")]]; // Set int here
        isTabSelected = YES; // will need to setup the settings
    }
}
%end
*/
