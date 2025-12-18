<script setup lang="ts">
import { onMounted, ref } from 'vue'
import FolderPanel from './components/LeftPanel.vue'
import FilePanel from './components/RightPanel.vue'
import { fetchFolders, fetchChildren, fetchContents } from './services/folderApi'
import type { FolderUI } from './types/ui/folder-ui'
import type { FileItem } from './types/domain/file'

const folders = ref<FolderUI[]>([])
const selectedFolder = ref<FolderUI | null>(null)
const contents = ref<FileItem[]>([])
const selectedFile = ref<FileItem | null>(null)
const error = ref('')

// Load root folders
onMounted(async () => {
  try {
    const res = await fetchFolders()
    folders.value = res.data.map((f) => ({
      ...f,
      isOpen: false,
      children: [],
      isLoading: false
    }))
  } catch (e) {
    error.value = 'Gagal load folders'
  }
})

// Handle folder click
const onFolderClick = async (folder: FolderUI) => {
  if (!folder.parent_id) {
    // Root folder
    folder.isOpen = !folder.isOpen
    selectedFolder.value = null
    contents.value = []

    if (folder.isOpen && !folder.children?.length) {
      folder.isLoading = true
      try {
        const res = await fetchChildren(folder.id)
        folder.children = res.data.map((f: any) => ({
          ...f,
          isOpen: false,
          children: []
        }))
      } finally {
        folder.isLoading = false
      }
    }
  }

  // fetch content
  selectedFolder.value = folder
  selectedFile.value = null
  try {
    const res = await fetchContents(folder.id)
    contents.value = res.data
  } catch {
    contents.value = []
  }
}

// Handle file click
const onFileClick = (file: FileItem) => {
  selectedFile.value = file
}
</script>

<template>
  <div class="container-fluid">
    <div class="row vh-100">
      <div class="col-3 border-end p-3 bg-light overflow-auto">
        <h5 class="mb-3">Explorer</h5>
        <FolderPanel :folders="folders" :selectedFolder="selectedFolder" @folder-click="onFolderClick" />
      </div>

      <div class="col-9 p-4">
        <h5>Detail Konten</h5>
        <hr>
        <FilePanel :contents="contents" :selectedFile="selectedFile" :selectedFolder="selectedFolder"
          @file-click="onFileClick" />
      </div>
    </div>
  </div>
</template>
